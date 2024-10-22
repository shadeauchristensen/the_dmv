class Facility
  attr_reader :name, :address, :phone, :services, :registered_vehicles, :collected_fees,
              :dmv_id, :name, :address, :city, :state, :zip, :phone, :hours, :services, 
              :coordinates

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

  def renew_license(registrant)
    if @services.include?('Renew License') && registrant.license_data[:license] && registrant.license_data[:written]
      registrant.renew_license
      true
    else
      false
    end
  end

  def administer_written_test(registrant)
    if @services.include?('Written Test')
      if registrant.age >= 16 && registrant.license_data[:written] && registrant.permit?
        registrant.pass_written_test
        return true
      else registrant.age < 16
        return false
      end
    end
  end

  def administer_road_test(registrant)
    if @services.include?('Road Test') && registrant.license_data[:written] && registrant.permit?
      registrant.pass_road_test
      true
    else
      false
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
