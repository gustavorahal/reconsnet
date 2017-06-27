# == Schema Information
#
# Table name: phone_numbers
#
#  id            :integer          not null, primary key
#  label         :string(255)
#  number        :string(255)      not null
#  provider      :string(255)
#  phone_type    :string(255)      not null
#  phonable_id   :integer
#  phonable_type :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class PhoneNumber < ApplicationRecord
  has_paper_trail meta: { person_id: lambda { |pn| pn.phonable_id if pn.phonable_type == 'Person' } }

  belongs_to :phonable, :polymorphic => true, required: false

  # Deixar lista em ordem alfabética
  PROVIDERS = %w(Claro GVT Net Oi Telefônica Tim Vivo)
  PHONE_TYPES = %w(Fixo Celular)
  LABELS = %w(Casa Trabalho Outro)

  validates_presence_of :number, :phone_type
  validates_inclusion_of :provider, in: PROVIDERS, allow_nil: true, allow_blank: true
  validates_inclusion_of :phone_type, in: PHONE_TYPES
  validates_plausible_phone :number

  phony_normalize :number, :default_country_code => 'BR'

  def to_s
    number
  end

end
