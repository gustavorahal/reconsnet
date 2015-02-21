class EventPolicy < ApplicationPolicy

  def emails?
    user.volunteer? or user.admin?
  end

  def attendance?
    user.volunteer? or user.admin?
  end

  def participants?
    user.volunteer? or user.admin?
  end

  def calendar?
    true
  end

end
