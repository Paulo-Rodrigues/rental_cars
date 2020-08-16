require 'rails_helper'

feature 'Admin register car model', type: :feature do
  scenario 'successfully' do
    CarCategory.create!(name: 'Economico', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)
    visit root_path

    click_on 'Modelos de carro'
    click_on 'Registrar novo modelo de carro'

    fill_in 'Nome', with: 'Fusca'
    fill_in 'Ano', with: 1963
    fill_in 'Fabricante', with: 'Volkswagen'
    fill_in 'Cavalos', with: '1.0'
    fill_in 'Tipo de combustível', with: 'Gasolina'
    select 'Economico', from: 'Categoria'

    click_on 'Enviar'
    
    expect(page).to have_content('Fusca')
    expect(page).to have_content('1963')
    expect(page).to have_content('Volkswagen')
    expect(page).to have_content('1.0')
    expect(page).to have_content('Gasolina')
    expect(page).to have_content('Economico')
  end
end
