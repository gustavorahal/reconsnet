class ActivityPolicy < ApplicationPolicy

  class Scope < Struct.new(:user, :scope)
    def resolve
      if user and (user.is_admin? or user.is_volunteer?)
        scope.all.order(:name)
      else
        scope.where.not(internal_only: true).all
      end
    end
  end

  def create?
    user.is_volunteer? or user.is_admin? if user
  end

  def new?
    user.is_volunteer? or user.is_admin? if user
  end

  def update?
    user.is_volunteer? or user.is_admin? if user
  end

  def edit?
    user.is_volunteer? or user.is_admin? if user
  end

  def destroy?
    user.is_volunteer? or user.is_admin? if user
  end

  def calendar?
    true
  end

  def emails?
    true
  end

  def archive?
    user.is_volunteer? or user.is_admin? if user
  end

  def unarchive?
    user.is_volunteer? or user.is_admin? if user
  end

  def attendance?
    true
  end

  def about?
    true
  end

end
