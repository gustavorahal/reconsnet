
##
# Classe de permissão base. A ideia é que ela seja super restritiva e seletivamente
# as subclasses vão relaxando as permissões.

class ApplicationPolicy < Struct.new(:user, :record)

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.admin? if user
  end

  def new?
    user.admin? if user
  end

  def update?
    user.admin? if user
  end

  def edit?
    user.admin? if user
  end

  def destroy?
    user.admin? if user
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end
end

