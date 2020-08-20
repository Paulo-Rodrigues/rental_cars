require 'rails_helper'

feature 'Admin view car models', type: :feature do
  scenario 'must be authenticated' do
    visit root_path
    click_on 'Modelos de carro'

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'empty list of car models' do
    user = User.create!(name: 'Username', email: 'test@test.com', password: 'password')
    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de carro'

    expect(page).to have_content('Nenhum modelo de carro cadastrado')
  end

  scenario 'list of car models' do
    user = User.create!(name: 'Username', email: 'test@test.com', password: 'password')
    login_as(user, scope: :user)
    car_category = CarCategory.create!(name: 'Economic', daily_rate: 105.5, car_insurance: 58.5,
third_party_insurance: 10.5)
    CarModel.create!(name: 'Uno', year: 1990, manufacturer: 'Fiat', motorization: '1.0', car_category_id: car_category.id, fuel_type: 'gasoline' )
    CarModel.create!(name: 'Beatle', year: 1963, manufacturer: 'Volkswagen', motorization: '1.0', car_category_id: car_category.id, fuel_type: 'gasoline' )

    visit root_path
    click_on 'Modelos de carro'

    expect(page).to have_content('Fiat')
    expect(page).to have_content('Volkswagen')
    expect(page).to have_content('Uno')
    expect(page).to have_content('Beatle')
    expect(page).to have_content('1963')
    expect(page).to have_content('1990')
  end

  scenario 'details of car models' do
    user = User.create!(name: 'Username', email: 'test@test.com', password: 'password')
    login_as(user, scope: :user)
    car_category = CarCategory.create!(name: 'Economic', daily_rate: 105.5, car_insurance: 58.5,
third_party_insurance: 10.5)
    CarModel.create!(name: 'Beatle', year: 1963, manufacturer: 'Volkswagen', motorization: '1.0', car_category_id: car_category.id, fuel_type: 'gasoline' )

    visit root_path
    click_on 'Modelos de carro'
    click_on 'Beatle - 1963'

    expect(page).to have_content('1.0')
    expect(page).to have_content('Volkswagen')
    expect(page).to have_content('gasoline')
    expect(page).to have_content('Beatle')
    expect(page).to have_content('1963')
    expect(page).to have_content('Economic')
  end
end
