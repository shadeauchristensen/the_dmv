require 'spec_helper'

RSpec.describe Facility do
  before(:each) do
    @facility = Facility.new(
      { name: 'DMV Tremont Branch', 
      address: '2855 Tremont Place Suite 118 Denver CO 80205', 
      phone: '(720) 865-4600' }
      )
  end

  describe '#initialize' do
    xit 'can initialize' do
      expect(@facility).to be_an_instance_of(Facility)
      expect(@facility.name).to eq('DMV Tremont Branch')
      expect(@facility.address).to eq('2855 Tremont Place Suite 118 Denver CO 80205')
      expect(@facility.phone).to eq('(720) 865-4600')
      expect(@facility.services).to eq([])
    end
  end

  describe '#add service' do
    xit 'can add available services' do
      expect(@facility.services).to eq([])
      @facility.add_service('New Drivers License')
      @facility.add_service('Renew Drivers License')
      @facility.add_service('Vehicle Registration')
      expect(@facility.services).to eq(
        ['New Drivers License', 
        'Renew Drivers License', 
        'Vehicle Registration']
      )
    end
  end

    xit 'sets up plate_type' do
      facility = Facility.new(
        { name: 'DMV Tremont Branch', 
        address: '2855 Tremont Place Suite 118 Denver CO 80205', 
        phone: '(720) 865-4600' }
    )
  end

  describe '#registration_cost' do
    xit 'calulates antique registration cost' do
      expect(@facility.registration_cost(:antique, 25)).to eq(25)
      expect(@facility.registration_cost(:antique, 24)).to eq(100)
    end

    xit 'calculates electric registration cost' do
      expect (@facility.registration_cost('ev')).to eq(200)
      expect(facility.plate_type).to eq(:ev)
    end

    xit 'defaults to $100 for regular registration' do
      expect(@facility.registration_cost('regular' )).to eq(100)
      expect(facility.plate_type).to eq(:regular)
    end
  end
end
