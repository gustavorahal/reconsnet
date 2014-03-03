# == Schema Information
#
# Table name: usuarios
#
#  id         :integer          not null, primary key
#  nome       :string(255)
#  uid        :string(255)
#  provider   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Usuario < ActiveRecord::Base

  def self.from_omniauth(auth)
    find_by(provider: auth['provider'], uid: auth['uid']) || create_with_omniauth(auth)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.nome = auth['info']['name']
    end
  end

end
