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
    it 'can initialize' do
      expect(@facility).to be_an_instance_of(Facility)
      expect(@facility.name).to eq('DMV Tremont Branch')
      expect(@facility.address).to eq('2855 Tremont Place Suite 118 Denver CO 80205')
      expect(@facility.phone).to eq('(720) 865-4600')
      expect(@facility.services).to eq([])
    end
  end

  describe '#add service' do
    it 'can add available services' do
      expect(@facility.services).to eq([])
      @facility.add_service('New Drivers License')
      @facility.add_service('Renew Drivers License')
      @facility.add_service('Vehicle Registration')
      expect(@facility.services).to eq(
        [ 'New Drivers License', 
        'Renew Drivers License', 
        'Vehicle Registration' ]
      )
    end

    it 'sets up plate_type' do
      facility = Facility.new(
        { name: 'DMV Tremont Branch', 
        address: '2855 Tremont Place Suite 118 Denver CO 80205', 
        phone: '(720) 865-4600' }
    )
    end
  end

  describe '#registration_cost' do
    it 'calulates antique registration cost' do
      expect(@facility.registration_cost(:antique, 25)).to eq(25)
      expect(@facility.registration_cost(:antique, 24)).to eq(100)
    end

    it 'calculates electric registration cost' do
      expect(@facility.registration_cost(:ev)).to eq(200)
    end

    it 'defaults to $100 for regular registration' do
      expect(@facility.registration_cost(:regular)).to eq(100)
    end
  end

  describe '#administer_written_test' do
    it 'administers a written test check for over 16' do
      registrant_1 = Registrant.new('Bruce', 18, true)
      registrant_2 = Registrant.new('Penny', 15, false)      
      
      expect(@facility.administration_written_test(registrant_1)).to eq('Pass')
      expect(@facility.administration_written_test(registrant_2)).to eq('Reject')
    end
  end
end
