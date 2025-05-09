class Api::ServiceHistoryEntriesController < ApplicationController
  def index
    if params[:car_id]
      entries = Car.find(params[:car_id]).service_history_entries
    else
      entries = ServiceHistoryEntry.all
    end
    render json: entries
  end

  def show
    entry = ServiceHistoryEntry.find(params[:id])
    render json: entry
  end

  def create
    car = Car.find(params[:car_id])
    entry = car.service_history_entries.create!(service_history_entry_params)
    render json: entry, status: :created
  end

  private

  def service_history_entry_params
    params.require(:service_history_entry).permit(:service_type, :notes, :serviced_at, :mileage)
  end
end
