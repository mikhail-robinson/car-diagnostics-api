require "test_helper"

class CarTest < ActiveSupport::TestCase
  test "should not save car without plate" do
    car = Car.new(plate: nil, make: "Toyota", model: "Corolla", year: 2020)
    assert_not car.save, "Saved the car without a plate"
  end
end
