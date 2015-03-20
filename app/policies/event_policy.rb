class EventPolicy < ApplicationPolicy

  def emails?
    user.volunteer? or user.admin? if user
  end

  def attendance?
    user.volunteer? or user.admin? if user
  end

  def archive?
    user.volunteer? or user.admin? if user
  end

  def unarchive?
    user.volunteer? or user.admin? if user
  end

  def calendar?
    true
  end

end
