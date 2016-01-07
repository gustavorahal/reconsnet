module UsersHelper

  def roles_friendly_display(user)
    # apenas listar papeis globais
    user.roles.where(resource_type: nil).map {|role| I18n.t "roles.#{role.name}" }.sort.join(', ')
  end

end


