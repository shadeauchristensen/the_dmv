class VehicleFactory
  attr_reader :data, 
              :vin, 
              :make, 
              :model, 
              :year, 
              :engine 
              
  def create_vehicles(data)
    vehicles = []
    data.each do |vehicle_data|
      vehicles << Vehicle.new(
          vin: vehicle_data[:vin_1_10],
          make: vehicle_data[:make],
          model: vehicle_data[:model],
          year: vehicle_data[:model_year],
          engine: :ev
        )
    end
    vehicles
  end
end