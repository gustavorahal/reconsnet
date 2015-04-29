class UserPolicy < ApplicationPolicy

  def index?
    user.is_admin? if user
  end

  def show?
    user.is_admin? if user
  end

end
