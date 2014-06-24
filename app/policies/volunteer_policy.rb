class VolunteerPolicy < ApplicationPolicy

  def create?
    user.role == 'Voluntariado' or user.admin?
  end

  def new?
    user.role == 'Voluntariado' or user.admin?
  end

  def update?
    user.role == 'Voluntariado' or user.admin?
  end

  def edit?
    user.role == 'Voluntariado' or user.admin?
  end

  def destroy?
    user.role == 'Voluntariado' or user.admin?
  end

end
