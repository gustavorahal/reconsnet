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

  EVENT_MANAGER_ROLE_AREAS = %w(Eventos Jurídico-Financeiro)
  VOLUNTEER_MANAGER_ROLE_AREAS = %w(Voluntariado)
  ADMIN_ROLE_AREAS = %w(Coordenação\ Geral Banco\ de\ Dados)

  validates :person, :person_id, presence: true, uniqueness: true

  belongs_to :person

  after_update :set_roles, if: :area_of_operation_changed?

  after_create :set_roles

  after_destroy do
    u = User.find_by(person_id: person_id)
    return unless u
    u.remove_role :volunteer
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

      u.remove_role(:event_manager) if EVENT_MANAGER_ROLE_AREAS.include?(area_of_operation_was)
      u.remove_role(:volunteer_manager) if VOLUNTEER_MANAGER_ROLE_AREAS.include?(area_of_operation_was)
      u.remove_role(:admin) if ADMIN_ROLE_AREAS.include?(area_of_operation_was)

      u.add_role(:event_manager) if EVENT_MANAGER_ROLE_AREAS.include?(area_of_operation)
      u.add_role(:volunteer_manager) if VOLUNTEER_MANAGER_ROLE_AREAS.include?(area_of_operation)
      u.add_role(:admin) if ADMIN_ROLE_AREAS.include?(area_of_operation)
    end

end
