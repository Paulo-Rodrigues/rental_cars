require 'rails_helper'

feature 'Admin register a client' do
  scenario 'must be authenticated' do
    visit root_path
    click_on 'Clientes'

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'successfully' do
    user = User.create!(name: 'Username', email: 'test@test.com', password: 'password')
    login_as(user, scope: :user)
    
    visit root_path
    click_on 'Clientes'
    click_on 'Cadastrar novo cliente'

    fill_in 'Nome', with: 'Cliente nome'
    fill_in 'CPF', with: "910.703.810-04"
    fill_in 'Email', with: 'client@test.com'
    click_on 'Enviar'

    expect(page).to have_content('Cliente nome')
    expect(page).to have_content('client@test.com')
    expect(page).to have_content('910.703.810-04')
  end
end
