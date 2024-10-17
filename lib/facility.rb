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
end
