class EventPolicy < ApplicationPolicy

  # Todos podem ver evento e calendário

  def show?
    true
  end

  def calendar?
    true
  end


  # Apenas Admin e Gestor de eventos GLOBAL podem criar e deletar

  def create?
    (user.is_admin? or user.is_event_admin?) if user
  end

  def new?
    (user.is_admin? or user.is_event_admin?) if user
  end

  def destroy?
    (user.is_admin? or user.is_event_admin?) if user
  end

  def archive?
    (user.is_admin? or user.is_event_admin?) if user
  end

  def unarchive?
    (user.is_admin? or user.is_event_admin?) if user
  end

  def roles?
    (user.is_admin? or user.is_event_admin?) if user
  end


  # Para edição, o gestor de eventos LOCAL do evento em questão tem permissão também

  def update?
    can_manage_event? if user
  end

  def edit?
    can_manage_event? if user
  end

  def emails?
    can_manage_event? or user.is_volunteer? if user
  end

  def attendance?
    can_manage_event? or user.is_volunteer? if user
  end

  # Método do Participations controller
  def record_attendance?
    can_manage_event? if user
  end

  private

    def can_manage_event?
      return true if (user.is_admin? or user.is_event_admin?)
      return true if user.has_role? :event_admin, record
    end


end
