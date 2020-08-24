require 'rails_helper'

feature 'Admin search for a client' do
  scenario 'search by name' do
    user = create_user; login_as(user)
    client1 = Client.create!(name: 'Fulano', cpf: CPF.new(CPF.generate).formatted , email: 'test1@test.com')
    client2 = Client.create!(name: 'Fulaninho', cpf: CPF.new(CPF.generate).formatted , email: 'test2@test.com')
    visit root_path

    fill_in 'Procurar', with: 'Fulan'
    click_on 'Pesquisar'

    expect(page).to have_content(client1.name)
    expect(page).to have_content(client2.name)
  end

  scenario 'search by cpf' do
    user = create_user; login_as(user)
    client1 = Client.create!(name: 'Fulano', cpf: CPF.new(CPF.generate).formatted , email: 'test1@test.com')
    visit root_path

    fill_in 'Procurar', with: client1.cpf
    click_on 'Pesquisar'

    expect(page).to have_content(client1.name)
    expect(page).to have_content(client1.cpf)
  end

  scenario 'link_to show' do
    user = create_user; login_as(user)
    client1 = Client.create!(name: 'Fulano', cpf: CPF.new(CPF.generate).formatted , email: 'test1@test.com')
    visit root_path

    fill_in 'Procurar', with: client1.cpf
    click_on 'Pesquisar'

    click_on "#{client1.name} - #{client1.cpf}"

    expect(current_path).to eq(client_path(client1))
  end

  scenario 'client not found' do
    user = create_user; login_as(user)
    visit root_path

    fill_in 'Procurar', with: 'Fulan'
    click_on 'Pesquisar'

    expect(page).to have_content('Não encontrado')
  end
end
