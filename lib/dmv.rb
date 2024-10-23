
class Dmv
  attr_reader :facilities

  def initialize
    @facilities = []
  end

  def add_facility(facility)
    @facilities << facility
  end

  def facilities_offering_service(service)
    @facilities.select do |facility|
      facility.services.include?(service)
    end
  end

  def collected_fees
    @collected_fees ||= 0
  end
  
  def register_vehicle(vehicle)
    @register_vehicles ||= []
    @register_vehicles << vehicle
  end
end
