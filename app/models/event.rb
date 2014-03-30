# == Schema Information
#
# Table name: eventos
#
#  id         :integer          not null, primary key
#  nome       :string(255)      not null
#  descricao  :string(255)
#  tipo       :string(255)
#  inicio     :datetime         not null
#  fim        :datetime         not null
#  created_at :datetime
#  updated_at :datetime
#


class Event < ActiveRecord::Base

  TIPOS = %w(Curso Simpósio)

  validates :name, presence: true, length: { minimum: 5 }
  validates :inicio, presence: true
  validates :fim, presence: true
  validates :tipo, inclusion: { in: TIPOS }

  has_many :participations, dependent: :destroy
  has_many :people, through: :participations

end
