require 'spec_helper'

RSpec.describe VehicleFactory do
    before(:each) do
      @factory = VehicleFactory.new
      @dds = DmvDataService.new
      @wa_ev_registrations = @dds.wa_ev_registrations
    end
  
    describe '#initialize' do
      it 'exists' do
        expect(@factory).to be_an_instance_of(VehicleFactory)
      end
    end
  
    describe '#create_vehicles' do
      it 'creates vehicles from wa_ev_registration data' do
        vehicles = @factory.create_vehicles(@wa_ev_registrations)
  
        expect(vehicles).to be_an(Array)
        expect(vehicles.any? { |vehicle| vehicle.make == 'TOYOTA' }).to be(true)
        expect(vehicles.any? { |vehicle| vehicle.model == 'Prius Plug-in' }).to be(true)
        expect(vehicles.any? { |vehicle| vehicle.year == '2013' }).to be(true)
      end
    end
  end