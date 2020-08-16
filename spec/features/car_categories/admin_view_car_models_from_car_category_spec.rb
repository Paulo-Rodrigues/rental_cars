require 'rails_helper'

feature 'Admin view car models from car category', type: :feature do
  before do
    car_category1 = CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)
    car_category2 =CarCategory.create!(name: 'Flex', daily_rate: 80, car_insurance: 8.5,
                        third_party_insurance: 8.5)

    CarModel.create!(name: 'Uno', year: 1990, manufacturer: 'Fiat', motorization: '1.0',
                     car_category_id: car_category1.id, fuel_type: 'gasoline' )
    CarModel.create!(name: 'Beatle', year: 1963, manufacturer: 'Volkswagen', motorization: '1.0',
                     car_category_id: car_category2.id, fuel_type: 'gasoline' )
  end

  scenario 'list of car from category 1' do
    visit root_path

    click_on 'Categorias'
    click_on 'Top'

    expect(page).to have_content('Uno')
  end

  scenario 'list of car from category 1' do
    visit root_path

    click_on 'Categorias'
    click_on 'Flex'

    expect(page).to have_content('Beatle')
  end
end
