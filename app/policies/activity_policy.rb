class ActivityPolicy < ApplicationPolicy

  class Scope < Struct.new(:user, :scope)
    def resolve
      # Mostrar atividades internas apenas para voluntários
      if user and (user.is_admin? or user.is_volunteer?)
        scope.all.order(:name)
      else
        scope.where.not(internal_only: true).all.order(:name)
      end
    end
  end


  # Todos podem ver atividades (filtro para atividades internas esta no método 'resolve')

  def index?
    true
  end

  def show?
    true
  end


  # Apenas Admin e Gestor de eventos GLOBAL podem criar e deletar

  def create?
    (user.is_admin? or user.is_event_admin?) if user
  end

  def new?
    (user.is_admin? or user.is_event_admin?) if user
  end

  def update?
    (user.is_admin? or user.is_event_admin?) if user
  end

  def edit?
    (user.is_admin? or user.is_event_admin?) if user
  end

  def destroy?
    (user.is_admin? or user.is_event_admin?) if user
  end

end
