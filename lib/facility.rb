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
    if vehicle_age && vehicle_age >= 25
      25
    elsif plate_type == :ev
      200
    else
      100
    end
  end

  def administration_written_test(registrant)
    if registrant.age >= 16
      p 'Pass'
    elsif registrant.age < 16
      p 'Reject'
    else
      p 'Error'
    end
  end
end
