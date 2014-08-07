# == Schema Information
#
# Table name: activities
#
#  id            :integer          not null, primary key
#  name          :string(255)      not null
#  summary       :string(255)      not null
#  description   :text
#  activity_type :string(255)
#  parent_id     :integer
#  internal_only :boolean          default(FALSE)
#  created_at    :datetime
#  updated_at    :datetime
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

  after_update :check_images, if: :description_changed?


  def to_s
    name
  end

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


  private

    ##
    # Deleta imagens que não fazem mais partes da descrição
    # O editor tinymce só lida com acrescentar imagens. Uma vez que uma imagem é deletada
    # do editor e salva, é necessário fazer um procedimento manual de checagem e deleção
    # da imagem. Este procedimento é feito aqui.

    def check_images
      Asset.where(assetable_id: id, assetable_type: 'Activity').each do |asset|
        unless description.include? asset.file.url
          asset.destroy
        end
      end
    end

end

