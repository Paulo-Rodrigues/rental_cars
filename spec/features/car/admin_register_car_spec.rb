require 'rails_helper'

feature 'Admin register a car' do
  scenario 'must be authenticated' do
    visit root_path
    click_on 'Cadastrar um carro'

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'successfully' do
    car_category = CarCategory.create!(name: 'Econômico', daily_rate: 105.5, car_insurance: 58.5,
third_party_insurance: 10.5)
    CarModel.create!(name: 'Uno', year: 2018, manufacturer: 'Fiat', motorization: '1.0', car_category_id: car_category.id, fuel_type: 'gasoline' )
    Subsidiary.create!(name: 'Filial 1', cnpj: '59.541.264/0001-03', address: 'address filial 1')
    

    user = User.create!(name: 'Username', email: 'test@test.com', password: 'password')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Cadastrar um carro'

    fill_in 'Placa', with: 'LOP4148'
    fill_in 'Cor', with: 'Preto'
    fill_in 'Quilometragem', with: 1200
    select 'Uno', from: 'Modelo de carro'
    select 'Filial 1' ,from:'Filial'
    
    click_on 'Enviar'

    expect(page).to have_content('LOP4148')
    expect(page).to have_content('Preto')
    expect(page).to have_content('1200')
    expect(page).to have_content('Uno')
    expect(page).to have_content('Filial 1')
  end

  scenario 'invalid fields' do
    car_category = CarCategory.create!(name: 'Econômico', daily_rate: 105.5, car_insurance: 58.5,
third_party_insurance: 10.5)
    CarModel.create!(name: 'Uno', year: 2018, manufacturer: 'Fiat', motorization: '1.0', car_category_id: car_category.id, fuel_type: 'gasoline' )
    Subsidiary.create!(name: 'Filial 1', cnpj: '59.541.264/0001-03', address: 'address filial 1')
    

    user = User.create!(name: 'Username', email: 'test@test.com', password: 'password')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Cadastrar um carro'

    fill_in 'Placa', with: ''
    fill_in 'Cor', with: ''
    fill_in 'Quilometragem', with: ''
    
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end
end
