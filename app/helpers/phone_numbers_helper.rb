
module PhoneNumbersHelper


  ##
  # Mostra número de telefone
  #
  # O campo label do telefone não é obrigatório, apenas o tipo (se é Fixo ou Celular)
  # portanto temos 2 formatos para casa label exista ou não
  #
  # 1. Com label
  #    Casa (Fixo): 45 3434 9736 (Vivo)
  #
  # 2. Sem label
  #    Fixo: 45 3434 9736 (Vivo)

  def phone_display(phone_number)
    PhoneNumbersHelper.gen_phone_display(phone_number)
  end


  ##
  # Para ser usado em modulos/classes fora de uma view (por exemplo na geração de pdf)

  def self.phone_display(phone_number)
    PhoneNumbersHelper.gen_phone_display(phone_number)
  end



  private

    def self.gen_phone_display(phone_number)
      if phone_number.label.present?
        full_label = "#{phone_number.label} (#{phone_number.phone_type})"
      else
        full_label = "#{phone_number.phone_type}"
      end

      txt = "#{full_label}: #{phone_number.number.phony_formatted}"
      txt += " (#{phone_number.provider})" if phone_number.provider.present?

      txt
    end


end