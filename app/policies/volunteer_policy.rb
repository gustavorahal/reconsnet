class VolunteerPolicy < ApplicationPolicy

  def create?
    user.group == 'Voluntariado' or user.admin?
  end

  def new?
    user.group == 'Voluntariado' or user.admin?
  end

  def update?
    user.group == 'Voluntariado' or user.admin?
  end

  def edit?
    user.group == 'Voluntariado' or user.admin?
  end

  def destroy?
    user.group == 'Voluntariado' or user.admin?
  end

end
