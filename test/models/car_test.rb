require "test_helper"

class CarTest < ActiveSupport::TestCase
  test "can create car" do
    car = Car.new(plate: "ABC123", make: "Toyota", model: "Corolla", year: 2020)
    assert car.save
  end

  test "should not save car without plate" do
    car = Car.new(plate: nil, make: "Toyota", model: "Corolla", year: 2020)
    assert_not car.save, "Saved the car without a plate"
  end

  test "should not save car without make" do
    car = Car.new(plate: "ABC123", make: nil, model: "Corolla", year: 2020)
    assert_not car.save, "Saved the car without a make"
  end

  test "should not save car without model" do
    car = Car.new(plate: "ABC123", make: "Toyota", model: nil, year: 2020)
    assert_not car.save, "Saved the car without a model"
  end

  test "should not save car without year" do
    car = Car.new(plate: "ABC123", make: "Toyota", model: "Corolla", year: nil)
    assert_not car.save, "Saved the car without a year"
  end

  test "can delete car" do
    car = Car.new(plate: "ABC123", make: "Toyota", model: "Corolla", year: 2020)
    car.save
    assert car.destroy
  end

  test "can get car by plate" do
    car = Car.new(plate: "ABC123", make: "Toyota", model: "Corolla", year: 2020)
    car.save
    assert_equal car, Car.find_by(plate: "ABC123")
  end

  test "can get all cars" do
    car = Car.new(plate: "ABC123", make: "Toyota", model: "Corolla", year: 2020)
    car.save
    car2 = Car.new(plate: "DEF456", make: "Ford", model: "F150", year: 2021)
    car2.save

    cars = Car.all
    assert_equal 2, cars.length
    assert_equal "Toyota", cars.first.make
    assert_equal "Ford", cars.last.make
  end

  test "car can have service history entries" do
    car = Car.new(plate: "ABC123", make: "Toyota", model: "Corolla", year: 2020)
    car.save
    service_history = ServiceHistoryEntry.new(
    car_id: car.id,
    service_type: "Oil Change",
    notes: "Oil changed",
    serviced_at: Date.today,
    mileage: 10000,
    created_at: Date.today,
    updated_at: Date.today
    )
    service_history.save
    assert_equal "Oil Change", car.service_history_entries.first.service_type
  end
end
