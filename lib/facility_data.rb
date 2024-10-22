class FacilityData
    attr_accessor :name, :address, :city, :state, :zip, :phone

    def initialize(data)
        @name = data[:name] || data[:dmv_office] || data[:branch_name]
        @address = (data[:address_li], data[:address__1]) || data[:address]
        @city = data[:city].split.map { |word| word.capitalize }.join(' ') # Converts city to title case
        @state = data[:state]
        @zip = data[:zip] || data[:zip_code]
        @phone = data[:phone]
    end
end

class FacilityFactory
    def create_facilities(data, source)
        data.map do |facility_data|
            case source
            when :colorado
                create_facility_co(facility_data)
            when :new_york
                create_facility_ny(facility_data)
            when :missouri
                create_facility_mo(facility_data)
            end
        end
    end
    
    def create_facility_co(data)
        FacilityData.new({
            name: data[:dmv_office],
            address: (data[:address_li], data[:address__1]),
            city: data[:city].split.map { |word| word.capitalize }.join(' '),
            state: data[:state],
            zip: data[:zip],
            phone: data[:phone]
        })
    end

    def create_facility_ny(data)
        FacilityData.new({
            name: data[:dmv_office],
            address: (data[:address_li], data[:address__1]),
            city: data[:city].split.map { |word| word.capitalize }.join(' '),
            state: data[:state],
            zip: data[:zip],
            phone: data[:phone]
        })
    end

    def create_facility_mo(data)
        FacilityData.new({
            name: data[:branch_name],
            address: (data[:address_li], data[:address__1]),
            city: data[:city].split.map { |word| word.capitalize }.join(' '),
            state: data[:state],
            zip: data[:zip_code],
            phone: data[:phone]
            })
    end
end

#     private

#     def clean_address(address_line_1, address_line_2)
#     "#{address_line_1}, #{address_line_2}".strip.sub(/,\s*$/, '') # Remove trailing commas if present
#     end
# end