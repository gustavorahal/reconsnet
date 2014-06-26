# == Schema Information
#
# Table name: tmks
#
#  id           :integer          not null, primary key
#  with_who_id  :integer          not null
#  from_who_id  :integer          not null
#  event_id     :integer          not null
#  when         :datetime
#  contact_type :string(255)
#  notes        :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Tmk < ActiveRecord::Base
  belongs_to :with_who, class_name: 'Person', foreign_key: 'with_who_id'
  belongs_to :from_who, class_name: 'Person', foreign_key: 'from_who_id'
  belongs_to :event

  CONTACT_TYPES = %w(Telefônico Pessoal Email)

  validates_inclusion_of :contact_type, in: CONTACT_TYPES, allow_nil: true, allow_blank: true
  validates_presence_of :with_who, :from_who, :event


  def to_s
    "Tmk/#{with_who.name}"
  end

  def self.text_search(query)
    if query.present?
      joins('LEFT JOIN people ON people.id = tmks.with_who_id OR people.id = tmks.from_who_id').
      joins('LEFT JOIN events ON events.id = tmks.event_id').
          where('people.name ilike :q OR contact_type ilike :q OR events.name ilike :q OR notes ilike :q', q: "%#{query}%").references(:people, :events).group('tmks.id')
    else
      joins(:with_who, :event).all
    end
  end

end
