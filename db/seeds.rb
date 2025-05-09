# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
Car.destroy_all

# Create sample cars
cars = [
  {
    plate: "ABC123",
    make: "Toyota",
    model: "Camry",
    year: 2020,
    service_history_entries: [
      {
        service_date: Date.today - 6.months,
        description: "Regular maintenance",
        cost: 150.00,
        mileage: 15000
      },
      {
        service_date: Date.today - 3.months,
        description: "Oil change",
        cost: 75.00,
        mileage: 25000
      }
    ]
  },
  {
    plate: "XYZ789",
    make: "Honda",
    model: "Civic",
    year: 2021,
    service_history_entries: [
      {
        service_date: Date.today - 4.months,
        description: "Brake service",
        cost: 300.00,
        mileage: 20000
      }
    ]
  },
  {
    plate: "DEF456",
    make: "Tesla",
    model: "Model 3",
    year: 2022,
    service_history_entries: [
      {
        service_date: Date.today - 2.months,
        description: "Tire rotation",
        cost: 100.00,
        mileage: 10000
      }
    ]
  }
]

# Create cars with their service history
cars.each do |car_data|
  service_entries = car_data.delete(:service_history_entries)
  car = Car.create!(car_data)

  service_entries.each do |entry_data|
    car.service_history_entries.create!(entry_data)
  end
end

puts "Created #{Car.count} cars with service history entries"
