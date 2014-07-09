# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  description :string(255)
#  start       :datetime         not null
#  finish      :datetime         not null
#  created_at  :datetime
#  updated_at  :datetime
#  activity_id :integer
#

class Event < ActiveRecord::Base

  include ConflictResolutionable

  # O usuário pode deixar em branco o field que o evento terá o nome da atividade
  #validates :name, presence: true, length: { minimum: 5 }
  validates :start, presence: true
  validates :finish, presence: true
  validate :handle_conflict, only: :update

  belongs_to :activity
  has_many :participations, dependent: :destroy
  has_many :people, through: :participations
  has_many :assets, as: :assetable, dependent: :destroy

  accepts_nested_attributes_for :assets, allow_destroy: true

  def to_s
    "#{name}"
  end

end
