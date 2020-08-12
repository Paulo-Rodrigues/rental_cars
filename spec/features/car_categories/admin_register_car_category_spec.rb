require 'rails_helper'

feature 'Admin register car category' do
  scenario 'from index page' do
    visit root_path

    click_on 'Categorias'

    expect(page).to have_link('Registrar uma nova categoria', href: new_car_category_path)
  end

  scenario 'successfully' do
    visit root_path
    click_on 'Categorias'
    click_on 'Registrar uma nova categoria'

    fill_in 'Nome', with: 'Top'
    fill_in 'Diária', with: '100'
    fill_in 'Seguro do carro', with: '50'
    fill_in 'Seguro para terceiros', with: '10'
    click_on 'Enviar'

    expect(current_path).to eq car_category_path(CarCategory.last)
    expect(page).to have_content('Top')
    expect(page).to have_content('R$ 100,00')
    expect(page).to have_content('R$ 50,00')
    expect(page).to have_content('R$ 10,00')
  end

  scenario 'failures' do
    visit root_path
    click_on 'Categorias'
    click_on 'Registrar uma nova categoria'

    fill_in 'Nome', with: ''
    fill_in 'Diária', with: ''
    fill_in 'Seguro do carro', with: ''
    fill_in 'Seguro para terceiros', with: ''
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco', count: 4) 
  end
end