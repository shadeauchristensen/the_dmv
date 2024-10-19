class Facility
  attr_reader :name, :address, :phone, :services

  def initialize(info)
    @name = info[:name]
    @address = info[:address]
    @phone = info[:phone]
    @services = []
  end

  def add_service(service)
    @services << service
  end

  def registration_cost(plate_type, vehicle_age = nil)
    return 25 if plate_type == :antique && vehicle_age && vehicle_age >= 25
    return 200 if plate_type == :ev
    return 100
  end
end
