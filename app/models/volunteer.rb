# == Schema Information
#
# Table name: volunteers
#
#  id                :integer          not null, primary key
#  person_id         :integer          not null
#  admission         :date
#  area_of_operation :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

class Volunteer < ActiveRecord::Base

  AREAS = %w(
Banco\ de\ Dados
Comunicação
Coordenação\ Geral
Eventos
Facilitação\ Interdimensional\ de\ Pesquisas
Jurídico-Financeiro
Parapedagogia
Parapercepciografia
Voluntariado)

  validates_presence_of :person

  belongs_to :person


  def to_s
    "Voluntário #{person.name}"
  end

end
