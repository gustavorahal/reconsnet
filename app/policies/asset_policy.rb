class AssetPolicy < ApplicationPolicy

  def show?
    # Por ora não liberamos anexos para pessoas de fora afinal não participaram do evento
    user.volunteer? or user.admin? if user
  end

end
