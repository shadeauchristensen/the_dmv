require 'spec_helper'

RSpec.describe FacilityData do
    before(:each) do
        @facility_data_co = {
            name: "DMV Tremont Branch",
            address_li: "2855 Tremont Place",
            address__1: "Suite 118",
            city: "Denver",
            state: "CO",
            zip: "80205",
            phone: "(720) 865-4600"
        }
        @facility_co = FacilityData.new(@facility_data_co)
    
        @facility_data_ny = {
            name: "Lake Placide Branch",
            address_li: "2693 Main Street",
            address__1: "Main Street",
            city: "LAKE PLACID",
            state: "NY",
            zip: "12946",
            phone: nil
        }
        @facility_ny = FacilityData.new(@facility_data_ny)
    
        @facility_data_mo = {
            branch_name: "Ferguson Branch",
            address_li: "10425 WEST FLORISSANT",
            city: "Canyon Country",
            state: "MO",
            zip_code: "63136",
            phone: "(314) 733-5316"
        }
        @facility_mo = FacilityData.new(@facility_data_mo)
    end
  
    describe '#initialize_data_co' do
        it 'exists and has attributes' do
            expect(@facility_co).to be_an_instance_of(FacilityData)
            expect(@facility_co.name).to eq('DMV Tremont Branch')
            expect(@facility_co.address).to eq('2855 Tremont Place, Suite 118')
            expect(@facility_co.city).to eq('Denver')
        end
    end
  
    describe '#initialize_data_ny' do
        it 'exists and has attributes' do
            expect(@facility_ny).to be_an_instance_of(FacilityData)
            expect(@facility_ny.name).to eq('Lake Placide Branch')
            expect(@facility_ny.address).to eq('2693 Main Street, Main Street')
            expect(@facility_ny.city).to eq('Lake Placid')
        end
    end
  
    describe '#initialize_data_mo' do
        it 'exists and has attributes' do
            expect(@facility_mo).to be_an_instance_of(FacilityData)
            expect(@facility_mo.name).to eq('Ferguson Branch')
            expect(@facility_mo.address).to eq('10425 WEST FLORISSANT')
            expect(@facility_mo.city).to eq('Canyon Country')
        end
    end
end
  
  RSpec.describe FacilityFactory do
    before(:each) do
        @facility_factory = FacilityFactory.new
        @dds = DmvDataService.new
        @co_dmv_offices = @dds.co_dmv_office_locations
        @ny_dmv_offices = @dds.ny_dmv_office_locations
        @mo_dmv_offices = @dds.mo_dmv_office_locations
    end
  
    describe '#create_facilities_CO' do
        it 'creates facilities from CO DMV office data' do
            @facilities_co = @facility_factory.create_facilities(@co_dmv_offices, :colorado)
    
            expect(@facilities_co).to be_an(Array)
            expect(@facilities_co.first).to be_an_instance_of(FacilityData)
            expect(@facilities_co.first.name).to eq('DMV Tremont Branch') 
            expect(@facilities_co.first.city).to eq('Denver')
        end
    end
  
    describe '#create_facilities_NY' do
        it 'creates facilities from NY DMV office data' do
            @facilities_ny = @facility_factory.create_facilities(@ny_dmv_offices, :new_york)
    
            expect(@facilities_ny).to be_an(Array)
            expect(@facilities_ny.first).to be_an_instance_of(FacilityData)
            expect(@facilities_ny.first.name).to eq('Lake Placide Branch') 
            expect(@facilities_ny.first.city).to eq('Lake Placid')  # City converted to title case
        end
    end
  
    describe '#create_facilities_MO' do
        it 'creates facilities from MO DMV office data' do
            @facilities_mo = @facility_factory.create_facilities(@mo_dmv_offices, :missouri)
    
            expect(@facilities_mo).to be_an(Array)
            expect(@facilities_mo.first.name).to eq('Ferguson Branch') 
            expect(@facilities_mo.first.city).to eq('Canyon Country')
        end
    end
end