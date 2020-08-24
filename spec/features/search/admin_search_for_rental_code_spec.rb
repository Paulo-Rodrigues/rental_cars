require 'rails_helper'

feature 'Admin search for rental code(token)' do
  scenario 'rental code not found' do
    user = create_user; login_as(user)
    visit root_path

    fill_in 'Procurar', with: "T1rolGjp"
    click_on 'Pesquisar'

    expect(page).to have_content('Não encontrado')
  end

  scenario 'with generated rental_code' do
    user = create_user; login_as(user)

    car_category = CarCategory.create!(name: 'Economic', daily_rate: 100,
                                       car_insurance: 100,
                                       third_party_insurance: 100)
    client = Client.create!(name: 'Cliente', cpf: '246.480.429-05',email: 'test@test.com')
    rental1 = Rental.create!(start_date: '22/08/2030', end_date: '24/08/2030',
                             car_category: car_category, client: client, user: user)

    rental2 = Rental.create!(start_date: '22/08/2030', end_date: '24/08/2030',
                             car_category: car_category, client: client, user: user)

    visit root_path

    fill_in 'Procurar', with: rental1.rental_code

    click_on 'Pesquisar'

    expect(page).to have_content(rental1.start_date)
    expect(page).to have_content(rental1.end_date)
    expect(page).to have_content(rental1.car_category.name)
    expect(page).to have_content(rental1.client.name)
    expect(page).to have_content(rental1.rental_code)
    expect(page).not_to have_content(rental2.rental_code)
  end

  scenario 'link_to rental(show)' do
    user = create_user; login_as(user)

    car_category = CarCategory.create!(name: 'Economic', daily_rate: 100,
                                       car_insurance: 100,
                                       third_party_insurance: 100)
    client = Client.create!(name: 'Cliente', cpf: '246.480.429-05',email: 'test@test.com')
    rental1 = Rental.create!(start_date: '22/08/2030', end_date: '24/08/2030',
                             car_category: car_category, client: client, user: user)


    visit root_path

    fill_in 'Procurar', with: rental1.rental_code

    click_on 'Pesquisar'

    click_on "Locação #{rental1.rental_code}"

    expect(current_path).to eq(rental_path(rental1))
  end
end
