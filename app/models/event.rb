# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  description :string(255)
#  start       :datetime         not null
#  finish      :datetime         not null
#  created_at  :datetime
#  updated_at  :datetime
#  activity_id :integer
#  archived    :boolean          default(FALSE)
#

class Event < ActiveRecord::Base
  resourcify

  include ConflictResolutionable

  # O usuário pode deixar em branco o field que o evento terá o nome da atividade
  #validates :name, presence: true, length: { minimum: 5 }
  validates :start, presence: true
  validates :finish, presence: true
  validate :handle_conflict, on: :update

  belongs_to :activity
  has_many :participations, dependent: :destroy
  has_many :people, through: :participations
  has_many :assets, as: :assetable, dependent: :destroy
  has_many :tmks

  accepts_nested_attributes_for :assets, allow_destroy: true

  scope :all_exclude_internal, -> { joins(:activity).where.not('activities.internal_only = true') }
  scope :sorted, -> { order('start DESC') }

  def to_s
    "#{name}"
  end


  ##
  # Nome com informação de data, util para select field onde diversos eventos tem nomes iguais
  # e portanto a data ajuda na diferenciação

  def name_with_date
    date_str = I18n.l start, format: '%d %b %Y'
    "#{name} <small>(#{date_str})</small>".html_safe
  end


  def self.next_event(exclude_internal=false)
    query = where('start > ?', Time.now).order(:start).limit(1)
    if exclude_internal
      query.where.not('activities.internal_only = true')
    end
    query[0]
  end


  def safely_destroyable?
    participations.empty? and tmks.empty? and assets.empty?
  end


  def enrolls
    participations.includes(:person).
        where(status: Participation.statuses[:enrolled]).order('people.name')
  end


  def pre_enrolls
    participations.includes(:person).
        where(status: Participation.statuses[:pre_enrolled]).order('people.name')
  end


  def interested
    participations.includes(:person).
        where(status: Participation.statuses[:interested]).order(:status, 'people.name')
  end


  def divulge
    participations.includes(:person).
        where(status: Participation.statuses[:divulge]).order(:status, 'people.name')
  end


  def organizers
    enrolls.where(p_type: Participation::ORGANIZER_P_TYPES)
  end


  def archivable?
    allow = true

    # Devem existir participantes inscritos
    allow = false if participations.where(status: Participation.statuses[:enrolled]).empty?

    # Só é possivel fechar um evento se todos os participantes estão inscritos e não em outros
    # estados "temporários"
    allow = false if participations.where.not(status: Participation.statuses[:enrolled]).any?

    # Todos participantes devem ter sua presença marcada
    allow = false if participations.where(attendance: nil).any?

    # Deve existir ao menos uma lista de presença escaneada
    allow = false if assets.where(asset_type: Asset.asset_types[:attendance_list]).empty?

    allow
  end


  ##
  # Eventos que aconteceram ou acontecerão

  def self.latest_events(exclude_internal=false)
    query = order(start: :desc).limit(5)
    if exclude_internal
      query.where.not('activities.internal_only = true')
    end
    query
  end

end
