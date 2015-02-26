class InventoriologyPolicy < ApplicationPolicy

  def index?
    true if user and (user.admin? or user.volunteer?)
  end

  def show?
    true if user and (user.admin? or user.volunteer?)
  end

end
