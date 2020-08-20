class CarsController < ApplicationController
  before_action :authenticate_user!

  def show
    @car = Car.find(params[:id])
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)

    if @car.save
      redirect_to @car
    else
      render 'new'
    end
  end

  private

  def car_params
    params.require(:car).permit(:license_plate, :color, :mileage, :car_model_id, :subsidiary_id)
  end
end
