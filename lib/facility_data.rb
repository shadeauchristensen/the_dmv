class FacilityData
    attr_reader :dmv_office, :address, :city, :state, :zip, :phone
  
    def initialize(data)
        @dmv_office = data[:dmv_office]
        @address = "#{data[:address_li]}, #{data[:address__1]}"
        @city = data[:city]
        @state = data[:state]
        @zip = data[:zip]
        @phone = data[:phone]
    end
end
  
class FacilityFactory
    def create_facilities(data)
        data.map do |facility_data|
            puts facility_data
            FacilityData.new(facility_data)
        end
    end
end

#adding address, address1 and 2 if app. and return all to one string
# look into .join
