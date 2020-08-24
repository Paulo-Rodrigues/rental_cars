require 'rails_helper'

RSpec.describe Rental, type: :model do
  context 'validations' do
    it 'token genereted' do
      car_category = CarCategory.create!(name: 'Economic', daily_rate: 100,
                                       car_insurance: 100,
                                       third_party_insurance: 100)
      client = Client.create!(name: 'Cliente', cpf: '246.480.429-05',email: 'test@test.com')
      user = User.create!(name: 'Fulano', email: 'testuser@test.com', password: 'password')
      rental = Rental.new(start_date: '22/08/2030', end_date: '24/08/2030',
                             car_category: car_category, client: client, user: user)

      rental.save
      rental.reload

      expect(rental.rental_code).to be_present
      expect(rental.rental_code.size).to eq(8)
      expect(rental.rental_code).to match(/^[A-Z0-9]+$/)
    end

  end
end
