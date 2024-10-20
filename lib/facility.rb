class Facility
  attr_reader :name, :address, :phone, :services

  def initialize(info)
    @name = info[:name]
    @address = info[:address]
    @phone = info[:phone]
    @services = []
    @register_vehicles = []
    @collected_fees = 0
    @written_tests = []
  end

  def add_service(service)
    @services << service
  end

  def register_vehicle(vehicle)
    if @services.include?('Vehicle Registration')
      vehicle.assign_registration_date
      vehicle.assign_plate_type
      @registered_vehicles << vehicle
      @collected_fees += calculate_fees(vehicle)
    end
  end

  def administer_written_test(registrant)
    if registrant.age >= 16 && registrant.permit?
      registrant.pass_written_test
      p 'Pass'
    elsif registrant.age < 16
      p 'Reject'
    else
      p 'Error'
    end
  end

  def registration_cost(plate_type, vehicle_age = nil)
    if vehicle_age && vehicle_age >= 25
      25
    elsif plate_type == :ev
      200
    else
      100
    end
  end

end



# impliment register vehicle, and checking for services for permit and roat test (rt is later)
# impliment facility registration cost