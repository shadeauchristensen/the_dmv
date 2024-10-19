class Facility
  attr_reader :name, :address, :phone, :services

  def initialize(name, address, phone)
    @name = info[:name]
    @address = info[:address]
    @phone = info[:phone]
    @services = []
  end

  def add_services(service)
    @services << service
  end

  def registration_cost(plate_type, vehicle_age)
    case plate_type
    when :antique
      25
    when :ev
      200
    else
      100
    end
  end
end
