require 'securerandom'

class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category
  belongs_to :user
  has_one :car_rental

  validates :start_date, :end_date, presence: true

  before_create :set_rental_code

  def total
    rent_days = end_date - start_date

    rent_days * car_category.daily_price
  end

  private
  def set_rental_code
    self.rental_code ||= SecureRandom.alphanumeric(8).upcase
  end

  def self.search(term)
    where(rental_code: term)
  end

end
