require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Filial 1', cnpj: '59.541.264/0001-03', address: 'address filial 1')
    Subsidiary.create!(name: 'Filial 2', cnpj: "84.769.501/5614-04", address: 'address filial 2')

    visit root_path
    click_on 'Subsidiarias'

    expect(page).to have_content('Filial 1')
    expect(page).to have_content('Filial 2')
  end

  scenario 'no subsidiary message' do
    visit root_path
    click_on 'Subsidiarias'

    expect(page).to have_content('Nenhuma subsidiaria cadastrada')
  end

  scenario 'show subsidiary' do
    Subsidiary.create!(name: 'Filial 1', cnpj: "84.769.501/5614-04", address: 'address filial 1')

    visit root_path
    click_on 'Subsidiarias'
    click_on 'Filial 1'

    expect(page).to have_content('Filial 1')
  end
end
