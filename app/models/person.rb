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
#  address_id       :integer
#  landline_number  :string(255)
#  mobile_number    :string(255)
#  marketing        :boolean
#  marketing_optout :hstore
#

class Person < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true, length: { minimum: 5 }
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :gender, inclusion: { :in => %w( Masculino Feminino) }
  validates_plausible_phone :mobile_number, :landline_number

  has_many :events
  has_many :participations
  has_one :address, :as => :addressable, dependent: :destroy
  accepts_nested_attributes_for :address, allow_destroy: true

  phony_normalize :landline_number, :default_country_code => 'BR'
  phony_normalize :mobile_number, :default_country_code => 'BR'

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
