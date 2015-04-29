class AssetPolicy < ApplicationPolicy

  def show?
    # Por ora não liberamos anexos para pessoas de fora afinal não participaram do evento
    user.is_volunteer? or user.is_admin? if user
  end

end
