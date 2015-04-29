class ParticipationPolicy < ApplicationPolicy

  def index?
    (user.is_admin? or user.is_volunteer?) if user
  end

  def show?
    (user.is_admin? or user.is_volunteer?) if user
  end

end
