# == Schema Information
#
# Table name: participacoes
#
#  id         :integer          not null, primary key
#  evento_id  :integer          not null
#  pessoa_id  :integer          not null
#  tipo       :string(255)      not null
#  status     :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#



TIPO = %w(
Aluno
Escriba Mediador
Meste\ de\ Cerimônia
Monitor
Palestrante
Professor
Professor\ Introdução
Professor\ Temático)

STATUS = %w(Inscrito Interessado Pré-Inscrito)

class Participacao < ActiveRecord::Base

  validates :tipo, inclusion: { in: TIPO }
  validates :status, inclusion: { in: STATUS }

  belongs_to :evento
  belongs_to :pessoa

  def self.statuses
    STATUS
  end

  def self.tipos
    TIPO
  end

end
