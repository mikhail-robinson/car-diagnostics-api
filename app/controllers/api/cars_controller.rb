class Api::CarsController < ApplicationController
  def index
    cars = Car.all
    render json: cars
  end

  def show
    car = Car.find(params[:id])
    render json: car, include: :service_history_entries
  end

  def create
    car = Car.create!(car_params)
    render json: car, status: :created
  end

  private

  def car_params
    params.require(:car).permit(:plate, :make, :model, :year)
  end


end
