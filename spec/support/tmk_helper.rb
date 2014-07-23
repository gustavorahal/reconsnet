def ui_new_tmk(contatado, quem_fez_contato, evento)
  select contatado.name, from: 'Contatado'
  select quem_fez_contato.name, from: 'Quem fez contato'
  select 'Telefônico', from: 'Tipo de contato'
  select evento.name, from: 'Evento'
  fill_in 'Notas', with: 'Pessoa interessada'
  click_on 'Salvar'
end