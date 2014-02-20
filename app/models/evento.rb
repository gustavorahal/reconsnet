# == Schema Information
#
# Table name: eventos
#
#  id         :integer          not null, primary key
#  nome       :string(255)      not null
#  descricao  :text
#  tipo       :string(255)
#  inicio     :datetime         not null
#  fim        :datetime         not null
#  created_at :datetime
#  updated_at :datetime
#

EVENTO_TIPOS = %w(Curso Simpósio)

class Evento < ActiveRecord::Base

  validates :nome, presence: true, length: { minimum: 5 }
  validates :tipo, inclusion: { in: EVENTO_TIPOS }

  has_many :pessoas

  def self.tipos_de_evento
    EVENTO_TIPOS
  end

end
