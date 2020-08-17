class CarModel < ApplicationRecord
  belongs_to :car_category
  validates :name, :fuel_type, :motorization, :manufacturer, :year, presence: true
end
