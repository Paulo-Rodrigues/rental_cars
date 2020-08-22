require 'rails_helper'

describe CarCategory, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      category = CarCategory.new

      category.valid?

      expect(category.errors[:name]).to include('não pode ficar em branco')
      expect(category.errors[:daily_rate]).to include('não pode ficar em '\
                                                      'branco')
      expect(category.errors[:third_party_insurance])
        .to include('não pode ficar em branco')
    end

    it 'name must be uniq' do
      CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                          third_party_insurance: 10.5)
      category = CarCategory.new(name: 'Top')

      category.valid?

      expect(category.errors[:name]).to include('já está em uso')
    end

    it 'daily_rate, car_insurance, third_party_insurance, must be > 0' do
      car_category = CarCategory.new(name: 'Top', daily_rate: 0, car_insurance: -5,
                          third_party_insurance: -2)
      car_category.valid?

      expect(car_category.errors[:daily_rate]).to include('deve ser maior que 0')
      expect(car_category.errors[:car_insurance]).to include('deve ser maior que 0')
      expect(car_category.errors[:third_party_insurance]).to include('deve ser maior que 0')
    end

    it 'not case sensitive' do

      CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                          third_party_insurance: 10.5)
      category = CarCategory.new(name: 'top')

      category.valid?

      expect(category.errors[:name]).to include('já está em uso')
    end
  end
end
