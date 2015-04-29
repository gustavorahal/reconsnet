class PersonPolicy < ApplicationPolicy


  def index?
    (user.is_admin? or user.is_volunteer?) if user
  end

  def show?
    (user.is_admin? or user.is_volunteer?) if user
  end

  def create?
    (user.is_admin? or user.is_volunteer?) if user
  end

  def new?
    (user.is_admin? or user.is_volunteer?) if user
  end

  def update?
    (user.is_admin? or user.is_volunteer?) if user
  end

  def edit?
    (user.is_admin? or user.is_volunteer?) if user
  end

  def destroy?
    (user.is_admin? or user.is_volunteer?) if user
  end

  def versions?
    (user.is_admin? or user.is_volunteer?) if user
  end


end
