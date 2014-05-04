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

  validates :name, presence: true, length: { minimum: 5 }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :gender, inclusion: { :in => %w( Masculino Feminino) }
  validates_plausible_phone :mobile_number, :landline_number

  has_many :events
  has_many :participations
  has_one :address, :as => :addressable
  accepts_nested_attributes_for :address

  phony_normalize :landline_number, :default_country_code => 'BR'
  phony_normalize :mobile_number, :default_country_code => 'BR'

end
