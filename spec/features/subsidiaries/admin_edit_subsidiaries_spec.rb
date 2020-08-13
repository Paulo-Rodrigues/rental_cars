require 'rails_helper'

feature 'Admin edit subsidiary', type: :feature do
  before do
    visit root_path
    click_on 'Subsidiarias'
    click_on 'Registrar uma nova subsidiaria'

    fill_in 'Nome', with: 'Filial 1'
    fill_in 'CNPJ', with: '567327662'
    fill_in 'Endereço', with: 'rua xxxx nº xxx'
    click_on 'Enviar'
  end

  scenario 'successfully' do
    click_on 'Editar'

    fill_in 'Nome', with: 'Filial 1 updated'
    click_on 'Enviar'

    expect(page).to have_content('Filial 1 updated')
  end
end
