# == Schema Information
#
# Table name: participations
#
#  id                 :integer          not null, primary key
#  event_id           :integer          not null
#  person_id          :integer          not null
#  participation_type :string(255)      not null
#  status             :string(255)      not null
#  created_at         :datetime
#  updated_at         :datetime
#

class Participation < ActiveRecord::Base

  TYPES = %w(
Aluno
Escriba Mediador
Mestre\ de\ Cerimônia
Monitor
Palestrante
Professor
Professor\ Introdução
Professor\ Temático)

  STATUS = %w(Inscrito Interessado Pré-Inscrito)


  validates :participation_type, inclusion: { in: TYPES }
  validates :status, inclusion: { in: STATUS }

  belongs_to :event
  belongs_to :person

  def to_s
    "#{person.name}"
  end

end
