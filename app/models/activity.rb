# == Schema Information
#
# Table name: activities
#
#  id            :integer          not null, primary key
#  name          :string(255)      not null
#  summary       :text             not null
#  description   :text
#  activity_type :string(255)
#  parent_id     :integer
#  internal_only :boolean          default(FALSE)
#  created_at    :datetime
#  updated_at    :datetime
#

class Activity < ApplicationRecord

  has_paper_trail meta: { activity_id: :id }
  has_attached_file :avatar, styles: { banner: '450x220#', medium: '350x170#', thumb: '200x100#' }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  include DeletableAttachment

  has_many :children, class_name: 'Activity', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Activity'
  has_many :events

  # Deixar lista em ordem alfabética
  TYPES = %w(Curso Oficina Programa Reunião Simpósio)

  validates :name, presence: true
  validates :summary, presence: true
  validates :activity_type, inclusion: { in: TYPES }

  after_update :check_images, if: :description_changed?


  def self.parent_activities
    Activity.where(id: parent_activities_ids)
  end

  def self.orphan_activities
    candidates = Activity.where(parent_id: nil).pluck(:id)
    ids = candidates - parent_activities_ids
    Activity.where(id: ids)
  end

  def to_s
    name
  end

  def self.next_activities(exclude_internal=false, limit=2)
    query = includes(:events).where('events.start > ?', Time.now).order('events.start').distinct
    if exclude_internal
      query = query.where.not(internal_only: true)
    end
    query[0..limit]
  end

  def next_event
    events.where('start > ?', Time.now).order(:start).first
  end

  ##
  # Inclui eventos das atividades filho

  def all_events
    activities_ids = []
    activities_ids += children.pluck(:id)
    activities_ids.append id
    Event.where(activity_id: activities_ids)
  end


  def safely_destroyable?
    events.empty? and children.empty?
  end

  private

    def self.parent_activities_ids
      Activity.select(:parent_id).distinct.pluck(:parent_id)
    end

    ##
    # Deleta imagens que não fazem mais partes da descrição
    # O editor tinymce só lida com acrescentar imagens. Uma vez que uma imagem é deletada
    # do editor e salva, é necessário fazer um procedimento manual de checagem e deleção
    # da imagem. Este procedimento é feito aqui.

    def check_images
      ResourceAsset.where(assetable_id: id, assetable_type: 'Activity').each do |asset|
        unless description.include? asset.file.url
          asset.destroy
        end
      end
    end

end

