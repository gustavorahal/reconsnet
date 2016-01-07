
module PhoneNumbersHelper


  def phone_display(phone_number)
    PhoneNumbersHelper.gen_phone_display(phone_number)
  end


  ##
  # Para ser usado em modulos/classes fora de uma view (por exemplo na geração de pdf)

  def self.phone_display(phone_number)
    PhoneNumbersHelper.gen_phone_display(phone_number)
  end



  private

    ##
    # Mostra número de telefone
    #
    # Em relação ao campo 'label', sendo este não obrigatório,
    # (apenas o 'tipo' é) temos 2 formas:
    #
    # 1. Com label
    #    Casa (Fixo): 45 3434 9736 (Vivo)
    #
    # 2. Sem label
    #    Fixo: 45 3434 9736 (Vivo)
    #
    #
    # Em relação ao codigo internacional, só mostrar se número do telefone não for do Brasil


    def self.gen_phone_display(phone_number)
      if phone_number.label.present?
        full_label = "#{phone_number.label} (#{phone_number.phone_type})"
      else
        full_label = "#{phone_number.phone_type}"
      end

      if phone_number.number.start_with?('55') # Brasil
        p_number = phone_number.number.phony_formatted
      else
        # internacional, mostra country code
        p_number = phone_number.number.phony_formatted(format: :international)
      end

      txt = "#{full_label}: #{p_number}"
      txt += " (#{phone_number.provider})" if phone_number.provider.present?

      txt
    end


end