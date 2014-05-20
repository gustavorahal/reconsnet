# == Schema Information
#
# Table name: people
#
#  id               :integer          not null, primary key
#  name             :string(255)      not null
#  gender           :string(255)
#  email            :string(255)
#  date_of_birth    :date
#  created_at       :datetime
#  updated_at       :datetime
#  profession       :string(255)
#  nationality      :string(255)
#  marketing        :boolean
#  marketing_optout :hstore
#

class Person < ActiveRecord::Base

  include ConflictResolutionable

  # manter em ordem alfabética
  OCCUPATIONS = %w(Aposentado Dentista Engenheiro Fonoaudiólogo Médico Professor Psicólogo)
  NATIONALITIES = %w(Argentino Brasileiro Paraguaio)
  GENDERS = %w(Masculino Feminino)

  validates :name, presence: true, uniqueness: true, length: { minimum: 5 }
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :gender, inclusion: { in:  GENDERS }
  validates_inclusion_of :occupation, in: OCCUPATIONS, allow_nil: true, allow_blank: true
  validates_inclusion_of :nationality, in: NATIONALITIES, allow_nil: true, allow_blank: true
  validate :handle_conflict, only: :update

  has_many :events
  has_many :participations
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :phone_numbers, as: :phonable, dependent: :destroy

  accepts_nested_attributes_for :addresses, allow_destroy: true, reject_if: lambda {|attributes| attributes['line1'].blank?}
  accepts_nested_attributes_for :phone_numbers, allow_destroy: true, reject_if: lambda {|attributes| attributes['number'].blank?}


  def age
    if date_of_birth
      now = Time.now.utc.to_date
      now.year - date_of_birth.year - (date_of_birth.to_date.change(:year => now.year) > now ? 1 : 0)
    end
  end

  def days_until_birthday
    if date_of_birth
      bday = Date.new(Date.today.year, date_of_birth.month, date_of_birth.day)
      bday += 1.year if Date.today >= bday
      (bday - Date.today).to_i
    end
  end

end
