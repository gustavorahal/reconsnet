# == Schema Information
#
# Table name: activities
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  parent_id   :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Activity < ActiveRecord::Base
  has_many :children, class_name: 'Activity', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Activity'
  has_many :events

  # Deixar lista em ordem alfabética
  TYPES = %w(Curso Oficina Programa Reunião Simpósio)

  validates :name, presence: true
  validates :summary, presence: true
  validates :activity_type, inclusion: { in: TYPES }


  ##
  # Inclui eventos dos atividades filho

  def all_events
    activities_ids = []
    activities_ids += children.pluck(:id)
    activities_ids.append id
    Event.where(activity_id: activities_ids)
  end

  ##
  # Inclui informações da atividade pai, caso exista

  def parent_display
    "parte do(a) #{parent.activity_type} #{parent.name}"
  end

end

