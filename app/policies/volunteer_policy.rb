class VolunteerPolicy < ApplicationPolicy

  def index?
    (user.is_admin? or user.is_volunteer?) if user
  end

  def show?
    (user.is_admin? or user.is_volunteer?) if user
  end

  def create?
    user.is_volunteer_admin? or user.is_admin? if user
  end

  def new?
    user.is_volunteer_admin? or user.is_admin? if user
  end

  def update?
    user.is_volunteer_admin? or user.is_admin? if user
  end

  def edit?
    user.is_volunteer_admin? or user.is_admin? if user
  end

  def destroy?
    user.is_volunteer_admin? or user.is_admin? if user
  end

end
