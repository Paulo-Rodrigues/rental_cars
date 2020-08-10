class CarCategory < ApplicationRecord
  validates :name, :daily_rate, :third_party_insurance, presence: true
  validates :name, uniqueness: {message: 'deve ser único'}
end
