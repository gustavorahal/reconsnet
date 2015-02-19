# == Schema Information
#
# Table name: people
#
#  id            :integer          not null, primary key
#  name          :string(255)      not null
#  gender        :string(255)
#  email         :string(255)
#  date_of_birth :date
#  occupation    :string(255)
#  nationality   :string(255)
#  marketing     :boolean
#  created_at    :datetime
#  updated_at    :datetime
#  cpf           :string(255)
#  rg            :string(255)
#  scholarity    :string(255)
#

class Person < ActiveRecord::Base
  has_paper_trail

  include ConflictResolutionable

  # manter em ordem alfabética
  NATIONALITIES = %w(Afegão Alemão Americano Angolano Antiguano Árabe Argélia Argentino Armeno Australiano Austríaco Bahamense Bangladesh Barbadiano Bechuano Belga Belizenho Boliviano Brasileiro Britânico Camaronense Canadense Chileno Chinês Cingalês Colombiano Comorense Costarriquenho Croata Cubano Dinamarquês Dominicana Dominicano Egípcio Equatoriano Escocês Eslovaco Esloveno Espanhol Francês Galês Ganés Granadino Grego Guatemalteco Guianense Guianês Haitiano Holandês Hondurenho Húngaro Iemenita Indiano Indonésio Inglês Iraniano Iraquiano Irlandês Israelita Italiano Jamaicano Japonês Líbio Malaio Marfinense Marroquino Mexicano Moçambicano Neozelandês Nepalês Nicaraguense Nigeriano Norte-coreano Noruego Omanense Palestino Panamenho Paquistanês Paraguaio Peruano Polonês Portorriquenho Português Qatarense Queniano Romeno Ruandês Russo Salvadorenho Santa-lucense São-cristovense São-vicentino Saudita Sérvio Sírio Somali Sueco Suíço Sul-africano Sul-coreano Surinamês Tailandês Timorense Trindadense Turco Ucraniano Ugandense Uruguaio Venezuelano Vietnamita Zimbabuense)
  SCHOLARITIES = %w(Ensino\ Fundamental
                    Ensino\ Médio
                    Superior\ Incompleto
                    Superior\ Completo
                    Pós-graduação
                    Mestrado
                    Doutorado)

  GENDERS = %w(Masculino Feminino)

  enum relationship: { single: 0, relationship: 1, engaged: 2, married: 3, widowed: 4,
                       separated: 5, divorced: 6, civil_union: 7, domestic_partnership: 8, evolutionary_duo: 9 }

  validates :name, presence: true, length: { minimum: 5 }
  validates_uniqueness_of :name, case_sensitive: false
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, allow_blank: true
  validates_uniqueness_of :email, case_sensitive: false
  validates_inclusion_of :gender, in:  GENDERS, allow_nil: true, allow_blank: true
  validates_inclusion_of :nationality, in: NATIONALITIES, allow_nil: true, allow_blank: true
  validate :handle_conflict, on: :update
  after_create :detect_gender, unless: :gender?
  after_create :subscribe_email_mkt, if: :marketing?
  after_update :update_email_mkt, if: :marketing_changed?
  after_destroy :unsubscribe_email_mkt

  has_one :volunteer, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :phone_numbers, as: :phonable, dependent: :destroy
  has_many :tmks, foreign_key: 'with_who_id', dependent: :destroy

  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :phone_numbers, allow_destroy: true, reject_if: lambda {|attributes| attributes['number'].blank?}


  scope :has_email, -> { where("email <> ''").order('LOWER(name)') }


  def to_s
    "#{name}"
  end


  def first_name
    name.strip.split(' ')[0]
  end

  def last_name
    name.strip.split(' ')[-1]
  end

  def enrolls
    participations.where(status: Participation.statuses[:enrolled]).includes(:event).order('events.start desc')
  end

  def safely_destroyable?
    participations.empty? and tmks.empty?
  end

  def self.text_search(query, order)
    order_str = ''
    case order
      when 'created_at' then order_str = 'people.created_at DESC'
      else order_str = 'LOWER(people.name)'
    end

    if query.present?
      joins("LEFT JOIN phone_numbers ON phone_numbers.phonable_id = people.id AND phone_numbers.phonable_type = 'Person'").
          where('name ilike :q or email ilike :q or occupation ilike :q or phone_numbers.number ilike :q', q: "%#{query}%").references(:phone_numbers).group('people.id').order(order_str)
    else
      includes(:phone_numbers, :addresses).order(order_str).all
    end
  end

  def age
    if date_of_birth.present?
      now = Time.now.utc.to_date
      now.year - date_of_birth.year - (date_of_birth.to_date.change(:year => now.year) > now ? 1 : 0)
    end
  end

  def days_until_birthday
    if date_of_birth.present?
      bday = Date.new(Date.today.year, date_of_birth.month, date_of_birth.day)
      bday += 1.year if Date.today >= bday
      (bday - Date.today).to_i
    end
  end


  ##
  # Como a detecção do gênero exige uma chamada à API do genderize.io escolheu-se fazer disso um job
  # para evitar transtornos por eventuais demoras decorrentes da rede

  def detect_gender
    SetPersonGenderJob.perform_later self
  end

  def unsubscribe_email_mkt
    EmailMktService.delay.unsubscribe(email)
  end

  def subscribe_email_mkt
    EmailMktService.delay.subscribe(self)
  end


  private

    def update_email_mkt
      if marketing and not EmailMktService.subscribed?(email)
        subscribe_email_mkt
      elsif not marketing and EmailMktService.subscribed?(email)
        unsubscribe_email_mkt
      end
    end

end
