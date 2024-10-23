require 'spec_helper'

RSpec.describe Facility do
  before(:each) do

    co_facilities = FacilityFactory.create_facilities
    ny_facilities = DmvDataService.new.ny_dmv_office_locations.map { |data| Facility.new(data) }
    mo_facilities = DmvDataService.new.mo_dmv_office_locations.map { |data| Facility.new(data) }

    @facilities = co_facilities + ny_facilities + mo_facilities
    @facilities = FacilityFactory.create_facilities
    @facility_1 = @facilities[0] if @facilities.size > 0
    @facility_2 = @facilities[1] if @facilities.size > 1
    @facility_3 = @facilities[2] if @facilities.size > 2

  end

  describe '#initialize' do
    it 'creates facilities from data service dynamically' do
      expect(@facilities).to be_an(Array)
      expect(@facility_1).to be_an_instance_of(Facility)
    end

    it 'assigns correct attributes to the first facility' do
      expect(@facility_1.name).to eq('DMV Tremont Branch')
      expect(@facility_1.address).to eq("2855 Tremont Place Suite 118 Denver CO 80205")
      expect(@facility_1.phone).not_to be_nil 
    end
  end

  describe '#add_service' do
    it 'can add available services to the first facility' do
      expect(@facility_1.services).to eq([])

      @facility_1.add_service('New Drivers License')
      @facility_1.add_service('Renew Drivers License')
      @facility_1.add_service('Vehicle Registration')

      expect(@facility_1.services).to eq([
        'New Drivers License', 
        'Renew Drivers License', 
        'Vehicle Registration'
      ])
    end
  end

  describe '#registration_cost' do
    it 'calulates antique registration cost' do
      expect(@facility_1.registration_cost(:antique, 25)).to eq(25)
      expect(@facility_1.registration_cost(:antique, 24)).to eq(100)
    end

    it 'calculates electric registration cost' do
      expect(@facility_1.registration_cost(:ev)).to eq(200)
      
    end

    it 'defaults to $100 for regular registration' do
      expect(@facility_1.registration_cost(:regular)).to eq(100)
      
    end
  end

  describe '#administer_written_test' do
    it 'administers a written test check for over 16' do
      @facility_1.add_service('Written Test')
      

      registrant_1 = Registrant.new('Bruce', 18, true)
      registrant_2 = Registrant.new('Penny', 16, true)
      registrant_3 = Registrant.new('Tucker', 15, false)      
      
      expect(@facility_1.administer_written_test(registrant_1)).to eq(false)
      expect(registrant_1.license_data[:written]).to eq(false)
      expect(@facility_1.administer_written_test(registrant_2)).to eq(false)
      expect(registrant_2.license_data[:written]).to eq(false)
      expect(@facility_1.administer_written_test(registrant_3)).to eq(false)
      expect(registrant_3.license_data[:written]).to eq(false)
    end
  end

  describe '#administer_road_test' do
    it 'administers a road test check for over 16' do
      @facility_1.add_service('Road Test') if @facility_1
      @facility_2.add_service('Road Test') if @facility_2
      @facility_3.add_service('Road Test') if @facility_3


      registrant_1 = Registrant.new('Bruce', 18, true)
      registrant_2 = Registrant.new('Penny', 16, false)   
      registrant_3 = Registrant.new('Tucker', 15, false)        

      registrant_1.pass_written_test
      expect(@facility_1.administer_road_test(registrant_1)).to eq(true)
      expect(registrant_1.license_data[:license]).to eq(true)
      registrant_2.pass_written_test
      expect(@facility_1.administer_road_test(registrant_2)).to eq(false)
      expect(registrant_2.license_data[:license]).to eq(false)
      registrant_3.pass_written_test
      expect(@facility_1.administer_road_test(registrant_3)).to eq(false)
      expect(registrant_3.license_data[:license]).to eq(false)
    end
  end

  describe '#renew_license' do
    it 'renew license' do
      @facility_1.add_service('Renew License')

      registrant_1 = Registrant.new('Bruce', 18, true)
      registrant_2 = Registrant.new('Penny', 16, true)   
      registrant_3 = Registrant.new('Tucker', 15, false)   
   
      registrant_1.pass_written_test
      registrant_1.pass_road_test
      expect(@facility_1.renew_license(registrant_1)).to eq(true)
      expect(registrant_1.license_data[:renewed]).to eq(true)
   
      registrant_2.pass_written_test
      registrant_2.pass_road_test
      expect(@facility_1.renew_license(registrant_2)).to eq(true)
      expect(registrant_2.license_data[:renewed]).to eq(true)
   
      registrant_3.pass_written_test
      registrant_3.pass_road_test
      expect(@facility_1.renew_license(registrant_3)).to eq(true)
      expect(registrant_3.license_data[:renewed]).to eq(true)
    end
  end
end


