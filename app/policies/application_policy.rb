
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
    user.is_admin? if user
  end

  def new?
    user.is_admin? if user
  end

  def update?
    user.is_admin? if user
  end

  def edit?
    user.is_admin? if user
  end

  def destroy?
    user.is_admin? if user
  end

  def versions?
    user.is_admin? if user
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end
end

