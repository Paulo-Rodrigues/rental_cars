require 'rails_helper'

feature 'Admin schedule rental' do
  scenario 'must be logged in(index)' do
    visit root_path

    click_on 'Locações'

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'successfully' do
    car_category = CarCategory.create!(name: 'Economic', daily_rate: 100,
                                       car_insurance: 100,
                                       third_party_insurance: 100)
    Client.create!(name: 'Cliente',
                   cpf: '246.480.429-05',
                   email: 'test@test.com')
    user = User.create!(name: 'Fulano', email: 'testuser@test.com',
                       password: 'password')
    login_as(user)

    visit root_path
    click_on 'Locações'
    click_on 'Agendar nova locação'

    fill_in 'Data de inicio', with: '21/08/2030'
    fill_in 'Data de término', with: '23/08/2030'
    select 'Cliente - 246.480.429-05', from: 'Cliente'
    select 'Economic', from: 'Categoria de carro'
    click_on 'Agendar'

    expect(page).to have_content('21/08/2030')
    expect(page).to have_content('23/08/2030')
    expect(page).to have_content('Cliente')
    expect(page).to have_content('246.480.429-05')
    expect(page).to have_content('Economic')
    expect(page).to have_content('R$ 600,00')
    expect(page).to have_content('Agendamento realizado com sucesso')
  end

  scenario 'failure' do
    car_category = CarCategory.create!(name: 'Economic', daily_rate: 100,
                                       car_insurance: 100,
                                       third_party_insurance: 100)
    Client.create!(name: 'Cliente',
                   cpf: '246.480.429-05',
                   email: 'test@test.com')
    user = User.create!(name: 'Fulano', email: 'testuser@test.com',
                       password: 'password')
    login_as(user)

    visit root_path
    click_on 'Locações'
    click_on 'Agendar nova locação'

    fill_in 'Data de inicio', with: ''
    fill_in 'Data de término', with: ''
    select 'Cliente - 246.480.429-05', from: 'Cliente'
    select 'Economic', from: 'Categoria de carro'
    click_on 'Agendar'

    expect(page).to have_content('não pode ficar em branco', count: 2)
  end
end
