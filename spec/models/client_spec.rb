require 'rails_helper'

RSpec.describe Client, type: :model do
  context 'validations' do
    it 'cannot be blank' do
      client = Client.new

      client.valid?

      expect(client.errors[:name]).to include('não pode ficar em branco')
      expect(client.errors[:cpf]).to include('não pode ficar em branco')
      expect(client.errors[:email]).to include('não pode ficar em branco')
    end

    it 'cpf must be unique' do
      Client.create!(name: 'Client 1', cpf: "064.815.064-09" , email: 'test@test.com')
      client = Client.new(name: 'Client 2', cpf: "064.815.064-09" , email: 'test@test.com')

      client.valid?

      expect(client.errors[:cpf]).to include('já está em uso')
      expect(client.errors[:email]).to include('já está em uso')
    end

    it 'cnpj must have 11 digits' do
      client = Client.new(name: 'Client 2', cpf: "64.815.064-09" , email: 'test@test.com')

      client.valid?

      expect(client.errors[:cpf]).to include('não possui o tamanho esperado (14 caracteres)')
    end

    it 'cnpj valid?' do
      client = Client.new(name: 'Client 2', cpf: "000.815.064-09" , email: 'test@test.com')
      client.valid?

      expect(client.errors[:cpf]).to include('não válido')
    end

  end
end
