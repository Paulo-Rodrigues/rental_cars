require 'rails_helper'

feature 'Admin view rental schedule' do
  scenario 'must be logged in' do
    car_category = CarCategory.create!(name: 'Economic', daily_rate: 100,
                                       car_insurance: 100,
                                       third_party_insurance: 100)
    client = Client.create!(name: 'Cliente', cpf: '246.480.429-05',email: 'test@test.com')
    user = User.create!(name: 'Fulano', email: 'testuser@test.com', password: 'password')
    rental = Rental.create!(start_date: '22/08/2030', end_date: '24/08/2030',
                   car_category: car_category, client: client, user: user)

    visit rental_path(rental)

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'successfully' do
    car_category = CarCategory.create!(name: 'Economic', daily_rate: 100,
                                       car_insurance: 100,
                                       third_party_insurance: 100)
    client = Client.create!(name: 'Cliente', cpf: '246.480.429-05',email: 'test@test.com')
    user = User.create!(name: 'Fulano', email: 'testuser@test.com', password: 'password')
    rental1 = Rental.create!(start_date: '22/08/2030', end_date: '24/08/2030',
                             car_category: car_category, client: client, user: user)
    rental2 = Rental.create!(start_date: '25/08/2030', end_date: '26/08/2030',
                             car_category: car_category, client: client, user: user)
    login_as(user)

    visit root_path
    click_on 'Locações'

    expect(page).to have_content(rental1.client.name)
    expect(page).to have_content(rental2.client.name)
    expect(page).to have_content(rental1.start_date)
    expect(page).to have_content(rental2.start_date)
    expect(page).to have_content(rental1.end_date)
    expect(page).to have_content(rental2.end_date)
    expect(page).to have_content(rental1.car_category.name)
    expect(page).to have_content(rental2.car_category.name)

  end

  scenario 'no rental scheduled' do
    user = User.create!(name: 'Fulano', email: 'testuser@test.com', password: 'password')
    login_as(user)

    visit root_path
    click_on 'Locações'

    expect(page).to have_content('Não há locações agendadas')
  end
end
