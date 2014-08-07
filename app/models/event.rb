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
  has_many :tmks

  accepts_nested_attributes_for :assets, allow_destroy: true

  scope :all_exclude_internal, -> { joins(:activity).where.not('activities.internal_only = true').order(start: :desc) }

  def to_s
    "#{name}"
  end


  ##
  # Nome com informação de data, util para select field onde diversos eventos tem nomes iguais
  # e portanto a data ajuda na diferenciação

  def name_with_date
    date_str = I18n.l start, format: '%d %b %Y'
    "#{name} (#{date_str})"
  end


  def self.next_event(exclude_internal=false)
    latest_events(exclude_internal)[0]
  end


  ##
  # Eventos que aconteceram ou acontecerão

  def self.latest_events(exclude_internal=false)
    query = order(start: :desc).limit(5)
    if exclude_internal
      query.where.not('activities.internal_only = true')
    end
    query
  end

end
