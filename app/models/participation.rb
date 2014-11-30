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

  STATUS = %w(Inscrito Interessado Pré-inscrito)

  validates_uniqueness_of :person, scope: :event
  validates :participation_type, inclusion: { in: TYPES }
  validates :status, inclusion: { in: STATUS }

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

  def self.participations(event)
    enrolled, pre_enrolled, interested  = [], [], []
    Participation.includes(:person).where(event: event).order('people.name').each do |p|
      case p.status
        when 'Inscrito' then enrolled.append(p)
        when 'Pré-inscrito' then pre_enrolled.append(p)
        when 'Interessado' then interested.append(p)
      end
    end

    [enrolled, pre_enrolled, interested]
  end


end
