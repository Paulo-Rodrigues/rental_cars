require 'rails_helper'

feature 'User sign in' do
  scenario 'from home page' do
    visit root_path

    expect(page).to have_link('Entrar')
  end

  scenario 'successfully' do
    User.create!(name: 'Name', email: 'test@test.com', password: 'password' )
    visit root_path
    click_on 'Entrar'

    fill_in 'Email', with: 'test@test.com'
    fill_in 'Senha', with: 'password'
    
    click_on 'Entrar'

    expect(page).to have_link('Sair')
    expect(page).not_to have_link('Entrar')
    expect(page).to have_content('Login efetuado com sucesso.')
  end
end
