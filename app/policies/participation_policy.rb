class ParticipationPolicy < ApplicationPolicy


  # Não voluntários não podem ver as participações

  def index?
    (user.is_admin? or user.is_volunteer?) if user
  end

  def show?
    (user.is_admin? or user.is_volunteer?) if user
  end


  # Apenas Admin e Gestor de eventos podem editar/modificar

  def create?
    user.is_event_manager? or user.is_admin? if user
  end

  def new?
    user.is_event_manager? or user.is_admin? if user
  end

  def update?
    user.is_event_manager? or user.is_admin? if user
  end

  def edit?
    user.is_event_manager? or user.is_admin? if user
  end

  def destroy?
    user.is_event_manager? or user.is_admin? if user
  end

end
