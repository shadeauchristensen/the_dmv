class VehicleFactory
  attr_reader :data, 
              :vin, 
              :make, 
              :model, 
              :year, 
              :engine 
              
  def create_vehicles(data)
    data.map do |vehicle_data|
      Vehicle.new(
        vin: vehicle_data[:vin_1_10],
        make: vehicle_data[:make],
        model: vehicle_data[:model],
        year: vehicle_data[:model_year],
        engine: :ev
      )
    end
  end
end