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

class Volunteer < ApplicationRecord

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

  EVENT_ADMIN_ROLE_AREAS = %w(Eventos Jurídico-Financeiro Parapedagogia)
  VOLUNTEER_ADMIN_ROLE_AREAS = %w(Voluntariado)
  PERSON_ADMIN_ROLE_AREAS = %w(Eventos Voluntariado)
  ADMIN_ROLE_AREAS = %w(Coordenação\ Geral Banco\ de\ Dados)

  validates :person, :person_id, presence: true, uniqueness: true

  belongs_to :person

  after_update :set_roles, if: :saved_change_to_area_of_operation?

  after_create :set_roles

  after_destroy do
    u = User.find_by(person_id: person_id)
    u.remove_role :volunteer if u
  end



  def to_s
    "Voluntário #{person.name}"
  end


  private

    def set_roles
      u = User.find_by(person_id: person_id)
      return unless u

      # Make sure volunteer role is always set
      u.add_role :volunteer

      u.remove_role(:person_admin) if PERSON_ADMIN_ROLE_AREAS.include?(area_of_operation_before_last_save)
      u.remove_role(:event_admin) if EVENT_ADMIN_ROLE_AREAS.include?(area_of_operation_before_last_save)
      u.remove_role(:volunteer_admin) if VOLUNTEER_ADMIN_ROLE_AREAS.include?(area_of_operation_before_last_save)
      u.remove_role(:admin) if ADMIN_ROLE_AREAS.include?(area_of_operation_before_last_save)

      u.add_role(:person_admin) if PERSON_ADMIN_ROLE_AREAS.include?(area_of_operation)
      u.add_role(:event_admin) if EVENT_ADMIN_ROLE_AREAS.include?(area_of_operation)
      u.add_role(:volunteer_admin) if VOLUNTEER_ADMIN_ROLE_AREAS.include?(area_of_operation)
      u.add_role(:admin) if ADMIN_ROLE_AREAS.include?(area_of_operation)
    end

end
