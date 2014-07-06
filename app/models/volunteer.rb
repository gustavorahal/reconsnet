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

  validates :person, :person_id, presence: true, uniqueness: true

  belongs_to :person

  after_update :set_user_group, if: :area_of_operation_changed?

  def to_s
    "Voluntário #{person.name}"
  end


  private

    def set_user_group
      u = User.find_by(person_id: person_id)
      u.update(group: area_of_operation) if u
    end

end
