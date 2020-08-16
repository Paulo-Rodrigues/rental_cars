require 'rails_helper'

describe Subsidiary, type: :model do
  context 'validations' do
    it 'cnpj cannot be blank' do
      subsidiady = Subsidiary.new

      subsidiady.valid?

      expect(subsidiady.errors[:cnpj]).to include('não pode ficar em branco')
    end

    it 'cnpj must be unique' do
      Subsidiary.create!(name: 'Filial 1', cnpj: "84.769.501/5614-04" , address: 'address filial 1')
      subsidiary = Subsidiary.new(name: 'Filial 2', cnpj: "84.769.501/5614-04", address: 'address filial 2')

      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to include('já está em uso')
    end

    it 'cnpj must have 18 digits' do
      subsidiary = Subsidiary.new(name: 'Filial 2', cnpj: "84.769.501/5614-0", address: 'address filial 2')

      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to include('não possui o tamanho esperado (18 caracteres)')
    end

    it 'cnpj valid?' do
      subsidiary = Subsidiary.new(name: 'Filial 2', cnpj: "84.769.501/5614-11", address: 'address filial 2')
      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to include('não válido')
    end

  end
end
