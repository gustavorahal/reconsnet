

TIPO_PARTICIPACAO = %w(
Aluno
Escriba Mediador
Meste\ de\ Cerimônia
Monitor
Palestrante
Professor
Professor\ Introdução
Professor\ Temático)


class EventoPessoa < ActiveRecord::Base

  validates :tipo_participacao, inclusion: { in: TIPO_PARTICIPACAO }

  belongs_to :evento
  belongs_to :pessoa


  def self.tipos_de_participacao
    TIPO_PARTICIPACAO
  end

end
