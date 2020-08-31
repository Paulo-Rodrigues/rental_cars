require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

feature 'User start rental' do

  scenario 'view only category cars' do

    car_category_a = CarCategory.create!(name: 'Economic', daily_rate: 100,
                                       car_insurance: 100,
                                       third_party_insurance: 100)

    car_category_expensive = CarCategory.create!(name: 'Expensive', daily_rate: 500,
                                       car_insurance: 300,
                                       third_party_insurance: 400)

    car_model_uno = CarModel.create!(name: 'Uno', year: 1990, manufacturer: 'Fiat', motorization: '1.0', car_category_id: car_category_a.id, fuel_type: 'gasoline' )


    car_model_fusion = CarModel.create!(name: 'Fusion', year: 2020, manufacturer: 'Ford', motorization: '2.0', car_category_id: car_category_expensive.id, fuel_type: 'gasoline' )

    subsidiary = Subsidiary.create!(name: 'Filial 1', cnpj: '59.541.264/0001-03', address: 'address filial 1')

    client = Client.create!(name: 'Cliente', cpf: '246.480.429-05',email: 'test@test.com')

    user = User.create!(name: 'Fulano', email: 'testuser@test.com', password: 'password')

    car = Car.create!(subsidiary: subsidiary,license_plate: 'LOP4148', color: 'prata', car_model: car_model_uno, mileage: 0)

    car = Car.create!(subsidiary: subsidiary,license_plate: 'LOP4145', color: 'preto', car_model: car_model_fusion, mileage: 0)
    
    rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now ,car_category: car_category_a, client: client, user: user)

    login_as(user)

    visit root_path

    fill_in 'Procurar', with: rental.rental_code
    click_on 'Pesquisar'

    click_on "Locação #{rental.rental_code}"

    click_on 'Iniciar locação'

    expect(page).to have_content('Uno')
    expect(page).to have_content('prata')
    expect(page).to have_content('LOP4148')

    expect(page).not_to have_content('Fusion')
    expect(page).not_to have_content('preto')
    expect(page).not_to have_content('LOP4145')

  end

  scenario 'successfully' do

    car_category = CarCategory.create!(name: 'Economic', daily_rate: 100,
                                       car_insurance: 100,
                                       third_party_insurance: 100)
    car_model = CarModel.create!(name: 'Uno', year: 1990, manufacturer: 'Fiat', motorization: '1.0', car_category_id: car_category.id, fuel_type: 'gasoline' )
    subsidiary = Subsidiary.create!(name: 'Filial 1', cnpj: '59.541.264/0001-03', address: 'address filial 1')
    client = Client.create!(name: 'Cliente', cpf: '246.480.429-05',email: 'test@test.com')
    schedule_user = User.create!(name: 'Fulano', email: 'testuser@test.com', password: 'password')
    car = Car.create!(subsidiary: subsidiary,license_plate: 'LOP4148', color: 'prata', car_model: car_model,
                     mileage: 0)
    rental = Rental.create!(start_date: '22/08/2030', end_date: '24/08/2030',car_category: car_category, client: client, user: schedule_user)
    user = User.create!(name: 'Outro', email: 'anothertestuser@test.com', password: 'password')

    login_as(user)

    visit root_path

    fill_in 'Procurar', with: rental.rental_code
    click_on 'Pesquisar'

    click_on "Locação #{rental.rental_code}"

    click_on 'Iniciar locação'
    select "#{car_model.name} - #{car.color} - #{car.license_plate}", from: 'Carros disponiveis'
    fill_in 'CNH', with: '123123123-12'

    travel_to Time.zone.local(2020, 10, 01, 12, 30, 45) do
      click_on 'Inicio'
    end

    expect(page).to have_content('Locação iniciada com sucesso')
    expect(page).to have_content(car_category.name)
    expect(page).to have_content(schedule_user.email)
    expect(page).to have_content(user.email)
    expect(page).to have_content(client.email)
    expect(page).to have_content(client.name)
    expect(page).to have_content(client.cpf)
    expect(page).to have_content(car_model.name)
    expect(page).to have_content(car.license_plate)
    expect(page).to have_content(car.color)
    expect(page).to have_content('123123123-12')
    expect(page).not_to have_link('Iniciar locação')
    expect(page).to have_content('qui, 01 de outubro de 2020, 12:30:45')
  end
end
