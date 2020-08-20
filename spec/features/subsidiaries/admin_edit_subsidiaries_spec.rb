require 'rails_helper'

feature 'Admin edit subsidiary', type: :feature do
  scenario 'successfully' do
    user = User.create!(name: 'Username', email: 'test@test.com', password: 'password')
    login_as(user, scope: :user)
    visit root_path
    click_on 'Subsidiarias'
    click_on 'Registrar uma nova subsidiaria'

    fill_in 'Nome', with: 'Filial 1'
    fill_in 'CNPJ', with: "84.769.501/5614-04"
    fill_in 'Endereço', with: 'rua xxxx nº xxx'
    click_on 'Enviar'
    click_on 'Editar'

    fill_in 'Nome', with: 'Filial 1 updated'
    click_on 'Enviar'

    expect(page).to have_content('Filial 1 updated')
  end
end
