# == Schema Information
#
# Table name: participations
#
#  id         :integer          not null, primary key
#  event_id   :integer          not null
#  person_id  :integer          not null
#  p_type     :integer          not null
#  status     :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Participation < ActiveRecord::Base

  enum status: { enrolled: 0, pre_enrolled: 1, interested: 2, divulge: 3 }

  enum p_type: { student: 0,
                lecturer: 1,
                scribe: 2,
                mediator: 3,
                master_of_ceremony: 4,
                monitor: 5,
                teacher: 6,
                teacher_theme: 7,
                teacher_intro: 8 }


  enum attendance: { present: 0, part_time: 1, absent: 2}

  # Participation types that are considered event organizers
  ORGANIZER_P_TYPES = [ p_types[:teacher],
                        p_types[:teacher_theme],
                        p_types[:teacher_intro],
                        p_types[:scribe],
                        p_types[:master_of_ceremony],
                        p_types[:lecturer],
                        p_types[:monitor]
                      ]

  validates_uniqueness_of :person, scope: :event

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
