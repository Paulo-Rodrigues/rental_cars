require 'rails_helper'

feature 'Admin register car model', type: :feature do
  scenario 'successfully' do
    visit root_path

    click_on 'Modelos de carro'
    click_on 'Registrar novo modelo de carro'

    fill_in 'Nome', with: 'Fusca'
    fill_in 'Ano', with: 1963
    fill_in 'Fabricante', with: 'Volkswagen'
    fill_in 'Cavalos', with: '1.0'
    fill_in 'Tipo de combustível', with: 'Gasolina'
    fill_in 'Categoria', with: ''

    click_on 'Enviar'
    
    expect(page).to have_content('Fusca')
    expect(page).to have_content('1963')
    expect(page).to have_content('Volkswagen')
    expect(page).to have_content('1.0')
    expect(page).to have_content('Gasolina')
    expect(page).to have_content('Economico')
  end
end
