
##
# Classe de permissão base. A ideia é que ela seja super restritiva e seletivamente
# as subclasses vão relaxando as permissões.

class ApplicationPolicy < Struct.new(:user, :record)

  self::Scope = Struct.new(:user, :scope) do
    def resolve
      if user.nil? # anonymous
        scope.all
      elsif user.admin?
        scope.all
      else
        scope.all
        #scope.where(:published => true)
      end
    end
  end

  def index?
    user.volunteer? or user.admin?
  end

  def show?
    user.volunteer? or user.admin?
  end

  def create?
    user.admin?
  end

  def new?
    user.admin?
  end

  def update?
    user.admin?
  end

  def edit?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end
end

