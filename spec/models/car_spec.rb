require 'rails_helper'

RSpec.describe Car, type: :model do
  context 'validations' do
    it 'cannot be blank' do
      car = Car.new

      car.valid?

      expect(car.errors[:license_plate]).to include('não pode ficar em branco')
      expect(car.errors[:color]).to include('não pode ficar em branco')
      expect(car.errors[:mileage]).to include('não pode ficar em branco')
    end

    it 'mileage >= 0' do
    car_category = CarCategory.create!(name: 'Econômico', daily_rate: 105.5, car_insurance: 58.5,
third_party_insurance: 10.5)
    car_model = CarModel.create!(name: 'Uno', year: 2018, manufacturer: 'Fiat', motorization: '1.0', car_category_id: car_category.id, fuel_type: 'gasoline' )
    subsidiary = Subsidiary.create!(name: 'Filial 1', cnpj: '59.541.264/0001-03', address: 'address filial 1')
    
      car = Car.new(license_plate: 'LOP4148', color: 'Preta', mileage: -2, car_model: car_model, subsidiary: subsidiary)

      car.valid?

      expect(car.errors[:mileage]).to include('deve ser maior ou igual a 0')

    end

    it 'license plate must be unique' do
    car_category = CarCategory.create!(name: 'Econômico', daily_rate: 105.5, car_insurance: 58.5,
third_party_insurance: 10.5)
    car_model = CarModel.create!(name: 'Uno', year: 2018, manufacturer: 'Fiat', motorization: '1.0', car_category_id: car_category.id, fuel_type: 'gasoline' )
    subsidiary = Subsidiary.create!(name: 'Filial 1', cnpj: '59.541.264/0001-03', address: 'address filial 1')
    
      Car.create!(license_plate: 'LOP4148', color: 'Preta', mileage: 1200, car_model: car_model, subsidiary: subsidiary)
      car = Car.new(license_plate: 'LOP4148', color: 'Branco', mileage: 1200)

      car.valid?

      expect(car.errors[:license_plate]).to include('já está em uso')
    end
  end
end
