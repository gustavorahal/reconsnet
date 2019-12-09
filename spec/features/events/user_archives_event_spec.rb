require 'rails_helper'


feature 'Arquivamento de evento' do

  let(:user) { create :user_admin }

  before :each do
    sign_in(user)
  end

  scenario 'evento não tem restrições para ser arquivado' do
    event = create(:event)
    part1 = create :participation, p_type: Participation.p_types[:student], event: event,
                   attendance: Participation.attendances[:part_present]
    part2 = create :participation, p_type: Participation.p_types[:teacher], event: event,
                   attendance: Participation.attendances[:part_present]
    asset = create :resource_asset, asset_type: ResourceAsset.asset_types[:attendance_list],
                   assetable_id: event.id, assetable_type: 'Event'

    visit event_path(event)

    click_on 'Arquivar'

    expect(page).to have_content 'Tudo certo para prosseguir com arquivamento!'

    click_on 'Prosseguir com arquivamento'

    expect(page).to have_content 'Evento arquivado com sucesso!'
    expect(page).to have_content 'Arquivado'
    expect(page).to_not have_content 'Nova participação'
    expect(page).to_not have_content 'Novo anexo'
  end


  scenario 'evento tem participações pendentes, não inscritos' do
    event = create(:event)
    part1 = create :participation, p_type: Participation.p_types[:student],
                   status: Participation.statuses[:pre_enrolled], event: event
    part2 = create :participation, p_type: Participation.p_types[:teacher], event: event
    asset = create :resource_asset, asset_type: ResourceAsset.asset_types[:attendance_list],
                   assetable_id: event.id, assetable_type: 'Event'

    visit event_path(event)

    click_on 'Arquivar'

    expect(page).to have_content 'Não é possível arquivar evento. Verificar pendências.'
    expect(page).to_not have_content 'Prosseguir com arquivamento'
  end


  scenario 'evento não tem lista de presença anexada' do
    event = create(:event)
    part1 = create :participation, p_type: Participation.p_types[:student], event: event,
                   attendance: Participation.attendances[:part_present]
    part2 = create :participation, p_type: Participation.p_types[:teacher], event: event,
                   attendance: Participation.attendances[:part_present]
    asset = create :resource_asset, asset_type: ResourceAsset.asset_types[:participant_material],
                   assetable_id: event.id, assetable_type: 'Event'

    visit event_path(event)

    click_on 'Arquivar'

    expect(page).to have_content 'Não é possível arquivar evento. Verificar pendências.'
    expect(page).to_not have_content 'Prosseguir com arquivamento'
  end

end