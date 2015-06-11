# == Schema Information
#
# Table name: participations
#
#  id                 :integer          not null, primary key
#  event_id           :integer          not null
#  person_id          :integer          not null
#  participation_type :string(255)      not null
#  status             :integer          not null
#  created_at         :datetime
#  updated_at         :datetime
#

class Participation < ActiveRecord::Base

  TYPES = %w(
Aluno
Conferencista
Escriba Mediador
Mestre\ de\ Cerimônia
Monitor
Palestrante
Professor
Professor\ Introdução
Professor\ Temático)

  enum status: { enrolled: 0, pre_enrolled: 1, interested: 2, divulge: 3 }


  validates_uniqueness_of :person, scope: :event
  validates :participation_type, inclusion: { in: TYPES }

  belongs_to :event
  belongs_to :person

  def to_s
    "Participation/#{person.name}"
  end

  def status_gender_aware
    if person.gender == 'Feminino'
      status.chomp('o') + 'a'
    else
      status
    end
  end


end
