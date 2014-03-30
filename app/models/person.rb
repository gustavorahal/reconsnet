# == Schema Information
#
# Table name: pessoas
#
#  id              :integer          not null, primary key
#  nome            :string(255)      not null
#  sexo            :string(1)
#  email           :string(255)
#  data_nascimento :date
#  tel_resid       :string(255)
#  tel_cel         :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class Person < ActiveRecord::Base

  validates :name, presence: true, length: { minimum: 5 }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :gender, inclusion: { :in => %w( Masculino Feminino) }

  has_many :events
  has_many :participations

end
