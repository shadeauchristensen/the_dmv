class Facility
  attr_reader :name, :address, :phone, :services, :registered_vehicles, :collected_fees

  def initialize(info)
    @name = info[:name]
    @address = info[:address]
    @phone = info[:phone]
    @services = []
    @registered_vehicles = []
    @collected_fees = 0
  end

  def add_service(service)
    @services << service
  end

  def administer_road_test(registrant)
    if @services.include?('Road Test') && registrant.license_data[:written]
    registrant.pass_road_test
      return 'Pass'  
    else  
      return 'Reject'
    end
  end

  def registered_vehicle(vehicle)
    if @services.include?('Vehicle Registration')
      vehicle.assign_registration_date
      vehicle.assign_plate_type
      @registered_vehicles << vehicle
      @collected_fees += calculate_fees(vehicle)
    end
  end

  def administer_written_test(registrant)
    return 'Written Test service not available' unless @services.include?('Written Test')
    
    if @services.include?('Written Test') 
      if registrant.age >= 16 && registrant.permit?
        registrant.pass_written_test
        return 'Pass'
      elsif registrant.age < 16
        return 'Reject'
      else
        return 'Error'
      end
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

  private

  def vehicle_age(vehicle)
    Date.today.year - vehicle.year
  end

  def calculate_fees(vehicle)
    registration_cost(vehicle.plate_type, vehicle_age(vehicle))
  end
end



# impliment register vehicle, and checking for services for permit and roat test (rt is later)
# impliment facility registration cost