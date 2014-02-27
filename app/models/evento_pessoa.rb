

TIPO_PARTICIPACAO = %w(
Aluno
Escriba Mediador
Meste\ de\ Cerimônia
Monitor
Palestrante
Professor
Professor\ Introdução
Professor\ Temático)

TIPO_STATUS = %w(Inscrito Interessado Pré-Inscrito)

class EventoPessoa < ActiveRecord::Base

  validates :tipo_participacao, inclusion: { in: TIPO_PARTICIPACAO }
  validates :status, inclusion: { in: TIPO_STATUS }

  belongs_to :evento
  belongs_to :pessoa


  def self.tipos_de_status
    TIPO_STATUS
  end

  def self.tipos_de_participacao
    TIPO_PARTICIPACAO
  end

end
