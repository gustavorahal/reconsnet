class EventPolicy < ApplicationPolicy

  # Todos podem ver

  def show?
    true
  end


  # Apenas Admin e Voluntário de eventos podem editar

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


  def archive?
    user.is_event_manager? or user.is_admin? if user
  end

  def unarchive?
    user.is_event_manager? or user.is_admin? if user
  end


  # Voluntários podem ver emails e gerar lista de presença

  def emails?
    user.is_event_manager? or user.is_volunteer? or user.is_admin? if user
  end

  def attendance?
    user.is_event_manager? or user.is_volunteer? or user.is_admin? if user
  end


  def calendar?
    true
  end

end
