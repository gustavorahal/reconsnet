# == Schema Information
#
# Table name: usuarios
#
#  id           :integer          not null, primary key
#  nome         :string(255)      not null
#  email        :string(255)      not null
#  identity_uid :string(255)
#  provider     :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Usuario < ActiveRecord::Base

  PAPEIS = %w(Admin Financeiro Voluntariado)

  has_one :person

  def admin?
    #papel == 'Admin'
    true
  end


end
