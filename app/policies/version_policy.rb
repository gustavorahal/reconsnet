
class PaperTrail::VersionPolicy < ApplicationPolicy

  def index?
    true if user and (user.admin?)
  end

end
