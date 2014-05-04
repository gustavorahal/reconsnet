# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  description :string(255)
#  event_type  :string(255)
#  start       :datetime         not null
#  finish      :datetime         not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Event < ActiveRecord::Base

  # Deixar lista em ordem alfabética
  TYPES = %w(Curso Reunião Simpósio)

  validates :name, presence: true, length: { minimum: 5 }
  validates :start, presence: true
  validates :finish, presence: true
  validates :event_type, inclusion: { in: TYPES }

  has_many :participations, dependent: :destroy
  has_many :people, through: :participations

end
