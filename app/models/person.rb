# == Schema Information
#
# Table name: people
#
#  id            :integer          not null, primary key
#  name          :string(255)      not null
#  gender        :string(255)
#  email         :string(255)
#  date_of_birth :date
#  created_at    :datetime
#  updated_at    :datetime
#

class Person < ActiveRecord::Base

  validates :name, presence: true, length: { minimum: 5 }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :gender, inclusion: { :in => %w( Masculino Feminino) }

  has_many :events
  has_many :participations

end
