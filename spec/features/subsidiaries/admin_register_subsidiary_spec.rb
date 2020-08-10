require 'rails_helper'

feature 'Admin register Subsidiary' do
  scenario 'from index page' do
    visit root_path

    click_on 'Subsidiarias'

    expect(page).to have_link('Registrar uma nova subsidiaria', href: new_subsidiary_path)
  end

  scenario 'successfully' do
    visit root_path
    click_on 'Subsidiarias'
    click_on 'Registrar uma nova subsidiaria'

    fill_in 'Nome', with: 'Filial 1'
    fill_in 'CNPJ', with: '567327662'
    fill_in 'Endereço', with: 'rua xxxx nº xxx'
    click_on 'Enviar'

    expect(current_path).to eq subsidiary_path(Subsidiary.last)
    expect(page).to have_content('Filial 1')
    expect(page).to have_content('567327662')
    expect(page).to have_content('rua xxxx nº xxx')
  end
end
