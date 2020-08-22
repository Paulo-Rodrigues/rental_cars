class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category
  belongs_to :user

  validates :start_date, :end_date, presence: true

  def total
    rent_days = end_date - start_date

    rent_days * car_category.daily_price
  end
end
