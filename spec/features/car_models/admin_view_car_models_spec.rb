require 'rails_helper'

feature 'Admin view car models', type: :feature do
  scenario 'list of car models' do
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

  scenario 'list of car models' do
    car_category = CarCategory.create!(name: 'Economic', daily_rate: 105.5, car_insurance: 58.5,
third_party_insurance: 10.5)
    CarModel.create!(name: 'Beatle', year: 1963, manufacturer: 'Volkswagen', motorization: '1.0', car_category_id: car_category.id, fuel_type: 'gasoline' )

    visit root_path
    click_on 'Modelos de carro'
    click_on 'Beatle'

    expect(page).to have_content('1.0')
    expect(page).to have_content('Volkswagen')
    expect(page).to have_content('gasoline')
    expect(page).to have_content('Beatle')
    expect(page).to have_content('1963')
    expect(page).to have_content('Economic')
  end
end
