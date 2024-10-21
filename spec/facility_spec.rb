require 'spec_helper'

RSpec.describe Facility do
  before(:each) do
    @facility_1 = Facility.new(
      { name: 'DMV Tremont Branch', 
      address: '2855 Tremont Place Suite 118 Denver CO 80205', 
      phone: '(720) 865-4600' }
    )
    @facility_2 = Facility.new(
      { name: 'DMV Northeast Branch', 
      address: '4685 Peoria Street Suite 101 Denver CO 80239', 
      phone: '(720) 865-4600' }
    )
    @facility_3 = Facility.new(
      { name: 'DMV Northwest Branch', 
      address: '3698 W. 44th Avenue Denver CO 80211', 
      phone: '(720) 865-4600' }
    )
  end

  describe '#initialize' do
    it 'can initialize facility_1' do
      expect(@facility_1).to be_an_instance_of(Facility)
      expect(@facility_1.name).to eq('DMV Tremont Branch')
      expect(@facility_1.address).to eq('2855 Tremont Place Suite 118 Denver CO 80205')
      expect(@facility_1.phone).to eq('(720) 865-4600')
      expect(@facility_1.services).to eq([])
    end
    
    it 'can initialize facility_2' do
      expect(@facility_2).to be_an_instance_of(Facility)
      expect(@facility_2.name).to eq('DMV Northeast Branch')
      expect(@facility_2.address).to eq('4685 Peoria Street Suite 101 Denver CO 80239')
      expect(@facility_2.phone).to eq('(720) 865-4600')
      expect(@facility_2.services).to eq([])
    end

    it 'can initialize facility_3' do
      expect(@facility_3).to be_an_instance_of(Facility)
      expect(@facility_3.name).to eq('DMV Northwest Branch')
      expect(@facility_3.address).to eq('3698 W. 44th Avenue Denver CO 80211')
      expect(@facility_3.phone).to eq('(720) 865-4600')
      expect(@facility_3.services).to eq([])
    end
  end

  describe '#add service facility_1' do
    it 'can add available services to facility_1' do
      expect(@facility_1.services).to eq([])
      @facility_1.add_service('New Drivers License')
      @facility_1.add_service('Renew Drivers License')
      @facility_1.add_service('Vehicle Registration')
      expect(@facility_1.services).to eq(
        [ 'New Drivers License', 
        'Renew Drivers License', 
        'Vehicle Registration' ]
      )
    end
  end

  describe '#add service facility_2' do
    it 'can add available services to facility_2' do
      expect(@facility_2.services).to eq([])
      @facility_2.add_service('New Drivers License')
      @facility_2.add_service('Renew Drivers License')
      @facility_2.add_service('Vehicle Registration')
      expect(@facility_2.services).to eq(
        [ 'New Drivers License', 
        'Renew Drivers License', 
        'Vehicle Registration' ]
      )
    end

    it 'can add available services to facility_3' do
      expect(@facility_3.services).to eq([])
      @facility_3.add_service('New Drivers License')
      @facility_3.add_service('Renew Drivers License')
      @facility_3.add_service('Vehicle Registration')
      expect(@facility_3.services).to eq(
        [ 'New Drivers License', 
        'Renew Drivers License', 
        'Vehicle Registration' ]
      )
    end

    it 'sets up plate_type for facility_1' do
      facility_1 = Facility.new(
        { name: 'DMV Tremont Branch', 
        address: '2855 Tremont Place Suite 118 Denver CO 80205', 
        phone: '(720) 865-4600' }
    )
    end

    it 'sets up plate_type for facility_2' do
      facility_2 = Facility.new(
        { name: 'DMV Northeast Branch', 
        address: '4685 Peoria Street Suite 101 Denver CO 80239', 
        phone: '(720) 865-4600' }
    )
    end

    it 'sets up plate_type for facility_3' do
      facility_3 = Facility.new(
        { name: 'DMV Northwest Branch', 
        address: '3698 W. 44th Avenue Denver CO 80211', 
        phone: '(720) 865-4600' }
    )
    end
  end

  describe '#registration_cost' do
    it 'calulates antique registration cost' do
      expect(@facility_1.registration_cost(:antique, 25)).to eq(25)
      expect(@facility_1.registration_cost(:antique, 24)).to eq(100)
      expect(@facility_2.registration_cost(:antique, 25)).to eq(25)
      expect(@facility_2.registration_cost(:antique, 24)).to eq(100)
    end

    it 'calculates electric registration cost' do
      expect(@facility_1.registration_cost(:ev)).to eq(200)
      expect(@facility_2.registration_cost(:ev)).to eq(200)
    end

    it 'defaults to $100 for regular registration' do
      expect(@facility_1.registration_cost(:regular)).to eq(100)
      expect(@facility_2.registration_cost(:regular)).to eq(100)
    end
  end

  describe '#administer_written_test' do
    it 'administers a written test check for over 16' do
      @facility_1.add_service('Written Test')
      @facility_2.add_service('Written Test')

      registrant_1 = Registrant.new('Bruce', 18, true)
      registrant_2 = Registrant.new('Penny', 16, true)
      registrant_3 = Registrant.new('Tucker', 15, false)      
      
      expect(@facility_1.administer_written_test(registrant_1)).to eq(false)
      expect(registrant_1.license_data[:written]).to eq(false)
      expect(@facility_1.administer_written_test(registrant_2)).to eq(false)
      expect(registrant_2.license_data[:written]).to eq(false)
      expect(@facility_1.administer_written_test(registrant_3)).to eq(false)
      expect(registrant_3.license_data[:written]).to eq(false)
  
      expect(@facility_2.administer_written_test(registrant_1)).to eq(false)
      expect(registrant_1.license_data[:written]).to eq(false)
      expect(@facility_2.administer_written_test(registrant_2)).to eq(false)
      expect(registrant_2.license_data[:written]).to eq(false)
      expect(@facility_2.administer_written_test(registrant_3)).to eq(false)
      expect(registrant_3.license_data[:written]).to eq(false)
    end
  end

  describe '#administer_road_test' do
    it 'administers a road test check for over 16' do
        @facility_1.add_service('Road Test')
        @facility_2.add_service('Road Test')
        @facility_3.add_service('Road Test')

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

        registrant_1.pass_written_test
        expect(@facility_2.administer_road_test(registrant_1)).to eq(true)
        expect(registrant_1.license_data[:license]).to eq(true)
        registrant_2.pass_written_test
        expect(@facility_2.administer_road_test(registrant_2)).to eq(false)
        expect(registrant_2.license_data[:license]).to eq(false)
        registrant_3.pass_written_test
        expect(@facility_2.administer_road_test(registrant_3)).to eq(false)
        expect(registrant_3.license_data[:license]).to eq(false)

        registrant_1.pass_written_test
        expect(@facility_3.administer_road_test(registrant_1)).to eq(true)
        expect(registrant_1.license_data[:license]).to eq(true)
        registrant_2.pass_written_test
        expect(@facility_3.administer_road_test(registrant_2)).to eq(false)
        expect(registrant_2.license_data[:license]).to eq(false)
        registrant_3.pass_written_test
        expect(@facility_3.administer_road_test(registrant_3)).to eq(false)
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
   
# it does not renew license if registrant has not passed written test
# it does not renew license if registrant has not passed road test

    end
  end
end


