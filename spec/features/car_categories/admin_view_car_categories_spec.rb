require 'rails_helper'

feature 'Admin view car categories' do
  scenario 'must be authenticated' do
    visit root_path
    click_on 'Categorias'

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'successfully' do
    user = User.create!(name: 'Username', email: 'test@test.com', password: 'password')
    login_as(user, scope: :user)
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)
    CarCategory.create!(name: 'Flex', daily_rate: 80, car_insurance: 8.5,
                        third_party_insurance: 8.5)

    visit root_path
    click_on 'Categorias'

    expect(page).to have_content('Top')
    expect(page).to have_content('Flex')
  end

  scenario 'and view details' do
    user = User.create!(name: 'Username', email: 'test@test.com', password: 'password')
    login_as(user, scope: :user)
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)
    CarCategory.create!(name: 'Flex', daily_rate: 80, car_insurance: 8.5,
                        third_party_insurance: 8.5)

    visit root_path
    click_on 'Categorias'
    click_on 'Top'

    expect(page).to have_content('Top')
    expect(page).to have_content('R$ 105,50')
    expect(page).to have_content('R$ 58,50')
    expect(page).to have_content('R$ 10,50')
    expect(page).not_to have_content('Flex')
  end

  scenario 'and no car categories are created' do
    user = User.create!(name: 'Username', email: 'test@test.com', password: 'password')
    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias'

    expect(page).to have_content('Nenhuma categoria cadastrada')
  end

  scenario 'and return to home page' do
    user = User.create!(name: 'Username', email: 'test@test.com', password: 'password')
    login_as(user, scope: :user)
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)

    visit root_path
    click_on 'Categorias'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to manufacturers page' do
    user = User.create!(name: 'Username', email: 'test@test.com', password: 'password')
    login_as(user, scope: :user)
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)

    visit root_path
    click_on 'Categorias'
    click_on 'Top'
    click_on 'Voltar'

    expect(current_path).to eq car_categories_path
  end
end
