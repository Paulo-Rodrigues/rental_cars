require 'rails_helper'

# user = User.create...
# login_as(user, scope: :user)

feature 'Admin view car models from car category', type: :feature do
  scenario 'must be authenticated' do
    visit root_path
    click_on 'Categorias'

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'list of car from category 1' do
    user = User.create!(name: 'Username', email: 'test@test.com', password: 'password')
    login_as(user, scope: :user)
    car_category1 = CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)
    car_category2 =CarCategory.create!(name: 'Flex', daily_rate: 80, car_insurance: 8.5,
                        third_party_insurance: 8.5)

    CarModel.create!(name: 'Uno', year: 1990, manufacturer: 'Fiat', motorization: '1.0',
                     car_category_id: car_category1.id, fuel_type: 'gasoline' )
    CarModel.create!(name: 'Beatle', year: 1963, manufacturer: 'Volkswagen', motorization: '1.0',
                     car_category_id: car_category2.id, fuel_type: 'gasoline' )
    visit root_path

    click_on 'Categorias'
    click_on 'Top'

    expect(page).to have_content('Uno')
  end

  scenario 'list of car from category 1' do
    user = User.create!(name: 'Username', email: 'test@test.com', password: 'password')
    login_as(user, scope: :user)
    car_category1 = CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)
    car_category2 =CarCategory.create!(name: 'Flex', daily_rate: 80, car_insurance: 8.5,
                        third_party_insurance: 8.5)

    CarModel.create!(name: 'Uno', year: 1990, manufacturer: 'Fiat', motorization: '1.0',
                     car_category_id: car_category1.id, fuel_type: 'gasoline' )
    CarModel.create!(name: 'Beatle', year: 1963, manufacturer: 'Volkswagen', motorization: '1.0',
                     car_category_id: car_category2.id, fuel_type: 'gasoline' )
    visit root_path

    click_on 'Categorias'
    click_on 'Flex'

    expect(page).to have_content('Beatle')
  end
end
