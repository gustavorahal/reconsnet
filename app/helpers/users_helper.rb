module UsersHelper

  def roles_friendly_display(user)
    user.roles.map {|role| I18n.t "roles.#{role.name}" }.sort.join(', ')
  end

end


