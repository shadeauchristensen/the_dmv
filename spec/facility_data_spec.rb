require 'spec_helper'

RSpec.describe FacilityData do
    before(:each) do
        @facility_data = {
        :dmv_office => "DMV Tremont Branch",
        :address => "2855 Tremont Place, Suite 118",
        :address_li => "2855 Tremont Place",
        :address__1 => "Suite 118",
        :city => "Denver",
        :state => "CO",
        :zip => "80205",
        :phone => "(720) 865-4600",
      }
        @facility = FacilityData.new(@facility_data)
    end
  
    describe '#initialize_data' do
        it 'exists' do
        expect(@facility).to be_an_instance_of(FacilityData)
        expect(@facility.dmv_office).to eq('DMV Tremont Branch')
        expect(@facility.address).to eq('2855 Tremont Place, Suite 118')
        expect(@facility.city).to eq('Denver')
        expect(@facility.state).to eq('CO')
        expect(@facility.zip).to eq('80205')
        expect(@facility.phone).to eq('(720) 865-4600')
        end
    end
end

RSpec.describe FacilityFactory do
    before(:each) do
        @facility_factory = FacilityFactory.new
        @dds = DmvDataService.new
        @co_dmv_offices = @dds.co_dmv_office_locations
    end
  
    describe '#initialize' do
        it 'exists' do
        expect(@facility_factory).to be_an_instance_of(FacilityFactory)
      end
    end
  
    describe '#create_facilities' do
        it 'creates facilities from CO DMV office data' do
        @facilities = @facility_factory.create_facilities(@co_dmv_offices)
  
        expect(@facilities).to be_an(Array)
        expect(@facilities.first).to be_an_instance_of(FacilityData)
        expect(@facilities.first.dmv_office).to eq('DMV Tremont Branch')
        expect(@facilities.first.city).to eq('Denver')
        end
    end
end

