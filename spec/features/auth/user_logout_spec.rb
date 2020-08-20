require 'rails_helper'

feature 'User logout ' do
  scenario 'from home page' do
    user = User.create!(name: 'Username', email: 'test@test.com', password: 'password')
    login_as(user, scope: :user)
    visit root_path

    expect(page).to have_link('Sair')
  end

  scenario 'successfully' do
    user = User.create!(name: 'Username', email: 'test@test.com', password: 'password')
    login_as(user, scope: :user)
    visit root_path
    click_on 'Sair'

    expect(page).to have_link('Entrar')
    expect(page).not_to have_link('Sair')
    expect(page).to have_content('Logout efetuado com sucesso.')
  end
end
