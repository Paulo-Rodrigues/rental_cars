class AddRentalCodeToRental < ActiveRecord::Migration[6.0]
  def change
    add_column :rentals, :rental_code, :string
  end
end
