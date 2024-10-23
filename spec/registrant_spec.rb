require 'spec_helper'

RSpec.describe Registrant do
    describe '#initialize' do
        it 'can initialize' do
            registrant_1 = Registrant.new('Bruce', 18, true )
            registrant_2 = Registrant.new('Penny', 16, false)
            registrant_3 = Registrant.new('Tucker', 15, false)

            expect(registrant_1).to be_an_instance_of(Registrant)
            expect(registrant_1.name).to eq('Bruce')
            expect(registrant_1.age).to eq(18)
            expect(registrant_1.permit?).to eq(true)
            expect(registrant_1.license_data).to eq(
                { written: false, license: false, renewed: false }
                ) 

            expect(registrant_2).to be_an_instance_of(Registrant)
            expect(registrant_2.name).to eq('Penny')
            expect(registrant_2.age).to eq(16)
            expect(registrant_2.permit?).to eq(false)
            expect(registrant_2.license_data).to eq(
                { written: false, license: false, renewed: false }
                )

            expect(registrant_3).to be_an_instance_of(Registrant)
            expect(registrant_3.name).to eq('Tucker')
            expect(registrant_3.age).to eq(15)
            expect(registrant_3.permit?).to eq(false)
            expect(registrant_3.license_data).to eq(
                { written: false, license: false, renewed: false }
                )
        end
    end

    describe '#can_earn_permit?' do
        it 'can earn a permit' do
            registrant_1 = Registrant.new('Bruce', 18, true)
            registrant_1.earn_permit
            expect(registrant_1.permit?).to eq(true)

            registrant_2 = Registrant.new('Penny', 16, false)
            registrant_2.earn_permit
            expect(registrant_2.permit?).to eq(true)

            registrant_3 = Registrant.new('Tucker', 15, false)
            registrant_3.earn_permit
            expect(registrant_3.permit?).to eq(true)
        end
    end

    describe '#pass_written_test' do
    it 'marks the written test as passed for all registrants' do
      registrant_1 = Registrant.new('Bruce', 18, true)
      registrant_2 = Registrant.new('Penny', 16, false)
      registrant_3 = Registrant.new('Tucker', 15, false)

      expect(registrant_1.license_data[:written]).to eq(false)
      registrant_1.pass_written_test
      expect(registrant_1.license_data[:written]).to eq(true)

      expect(registrant_2.license_data[:written]).to eq(false)
      registrant_2.pass_written_test
      expect(registrant_2.license_data[:written]).to eq(true)

      expect(registrant_3.license_data[:written]).to eq(false)
      registrant_3.pass_written_test
      expect(registrant_3.license_data[:written]).to eq(true)
    end
  end

    describe '#pass_road_test' do
        it 'marks the road test as passed for all registrants' do
        registrant_1 = Registrant.new('Bruce', 18, true)
        registrant_2 = Registrant.new('Penny', 16, false)
        registrant_3 = Registrant.new('Tucker', 15, false)

        expect(registrant_1.license_data[:license]).to eq(false)
        registrant_1.pass_road_test
        expect(registrant_1.license_data[:license]).to eq(true)

        expect(registrant_2.license_data[:license]).to eq(false)
        registrant_2.pass_road_test
        expect(registrant_2.license_data[:license]).to eq(true)

        expect(registrant_3.license_data[:license]).to eq(false)
        registrant_3.pass_road_test
        expect(registrant_3.license_data[:license]).to eq(true)
        end
    end

    describe '#pass_license' do
        it 'revokes the license for all registrants' do
        registrant_1 = Registrant.new('Bruce', 18, true)
        registrant_2 = Registrant.new('Penny', 16, false)
        registrant_3 = Registrant.new('Tucker', 15, false)

        registrant_1.pass_road_test
        registrant_2.pass_road_test
        registrant_3.pass_road_test

        expect(registrant_1.license_data[:license]).to eq(true)
        expect(registrant_2.license_data[:license]).to eq(true)
        expect(registrant_3.license_data[:license]).to eq(true)

        registrant_1.pass_license
        registrant_2.pass_license
        registrant_3.pass_license

        expect(registrant_1.license_data[:license]).to eq(false)
        expect(registrant_2.license_data[:license]).to eq(false)
        expect(registrant_3.license_data[:license]).to eq(false)
        end
    end
end