require 'date' #using this so i can use the .date method

class Vehicle
  attr_reader :vin,
              :year,
              :make,
              :model,
              :engine,
              :registration_date

  def initialize(vehicle_details)
    @vin = vehicle_details[:vin]
    @year = vehicle_details[:year]
    @make = vehicle_details[:make]
    @model = vehicle_details[:model]
    @engine = vehicle_details[:engine]
    @plate_type = nil
    @registration_date = nil
  end

  def antique?
    @year < 1995
  end
  
  def electric_vehicle?
    @engine == :ev
  end

  def assign_plate_type
    if @year < Date.today.year - 25
      @plate_type = :antique
    elsif @engine == :ev
      @plate_type = :ev
    else
      @plate_type = :regular
    end
  end

  def assign_registration_date
    @registration_date = Date.today
  end
end
