class EventPolicy < ApplicationPolicy

  def emails?
    user.volunteer? or user.admin?
  end


end
