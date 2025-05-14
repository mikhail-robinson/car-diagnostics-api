require "test_helper"

class ServiceHistoryEntryTest < ActiveSupport::TestCase
  setup do
    @car = Car.create!(
      plate: "ABC123",
      make: "Toyota",
      model: "Corolla",
      year: 2020
    )
  end
  test "can create service history entry" do
    service_history_entry = ServiceHistoryEntry.new(car_id: @car.id, service_type: "Oil Change", notes: "Oil changed", serviced_at: Date.today, mileage: 10000)
    service_history_entry.save
    service_history_entries = ServiceHistoryEntry.all

    assert_equal "Oil Change", service_history_entry.service_type
    assert_equal 1, service_history_entries.length
  end

  test "service history entry belongs to a car" do
    service_history_entry = ServiceHistoryEntry.create!(
      car: @car,
      service_type: "Oil Change",
      notes: "Oil changed",
      serviced_at: Date.today,
      mileage: 10000
    )
    assert_equal @car, service_history_entry.car
  end

  test "should not save service history entry without car_id" do
    service_history_entry = ServiceHistoryEntry.new(service_type: "Oil Change", notes: "Oil changed", serviced_at: Date.today, mileage: 10000)
    assert_not service_history_entry.save
  end

  test "service history entry can be edited" do
    service_history_entry = ServiceHistoryEntry.new(car_id: @car.id, service_type: "Oil Change", notes: "Oil changed", serviced_at: Date.today, mileage: 10000)
    service_history_entry.save
    service_history_entry.update(service_type: "Oil Change three times")

    assert_equal "Oil Change three times", service_history_entry.service_type
  end

  test "service history entry can be deleted" do
    service_history_entry = ServiceHistoryEntry.new(car_id: @car.id, service_type: "Oil Change", notes: "Oil changed", serviced_at: Date.today, mileage: 10000)
    service_history_entry.save
    service_history_entry.destroy
    assert_equal 0, ServiceHistoryEntry.count
  end

  test "can get all service history entries" do
    service_history_entry = ServiceHistoryEntry.new(car_id: @car.id, service_type: "Oil Change", notes: "Oil changed", serviced_at: Date.today, mileage: 10000)
    service_history_entry.save
    service_history_entry2 = ServiceHistoryEntry.new(car_id: @car.id, service_type: "Oil Change two", notes: "Oil changed two", serviced_at: Date.today, mileage: 20000)
    service_history_entry2.save

    service_history_entries = ServiceHistoryEntry.all

    assert_equal 2, service_history_entries.length
    assert_equal "Oil Change", service_history_entries.first.service_type
    assert_equal "Oil Change two", service_history_entries.last.service_type
  end

  test "can handle future service dates" do
    service_history_entry = ServiceHistoryEntry.new(
      car: @car,
      service_type: "Scheduled Maintenance",
      serviced_at: Date.today + 30.days,
      mileage: 10000
    )
    assert service_history_entry.save
  end

  test "can handle zero mileage" do
    service_history_entry = ServiceHistoryEntry.new(
      car: @car,
      service_type: "Pre-delivery Inspection",
      serviced_at: Date.today,
      mileage: 0
    )
    assert service_history_entry.save
  end

  test "deleting a car deletes associated service history entries" do
    ServiceHistoryEntry.create!(
      car: @car,
      service_type: "Oil Change",
      serviced_at: Date.today,
      mileage: 10000
    )

    @car.destroy
    assert_equal 0, ServiceHistoryEntry.count
  end

  test "can find service history entries by service type" do
    ServiceHistoryEntry.create!(
      car: @car,
      service_type: "Oil Change",
      serviced_at: Date.today,
      mileage: 10000
    )
    ServiceHistoryEntry.create!(
      car: @car,
      service_type: "Oil Change two",
      serviced_at: Date.today,
      mileage: 10000
    )

    assert_equal 1, ServiceHistoryEntry.where(service_type: "Oil Change").count
  end
end
