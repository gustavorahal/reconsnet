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


class Participation < ActiveRecord::Base

  TIPOS = %w(
Aluno
Escriba Mediador
Meste\ de\ Cerimônia
Monitor
Palestrante
Professor
Professor\ Introdução
Professor\ Temático)

  STATUS = %w(Inscrito Interessado Pré-Inscrito)


  validates :type, inclusion: { in: TIPOS }
  validates :status, inclusion: { in: STATUS }

  belongs_to :event
  belongs_to :person

end
