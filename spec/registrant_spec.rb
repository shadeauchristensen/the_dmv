require 'rspec'
require './lib/registrant'
# each class method 
RSpec.describe Registrant do
    registrant_1 = Registrant.new('Bruce', 18, true )
    registrant_2 = Registrant.new('Penny', 15, false)

    it 'exists' do
      expect(registrant_1).to be_an_instance_of(Registrant)
      expect(registrant_1.name).to eq('Bruce')
      expect(registrant_1.age).to eq(18)
      expect(registrant_1.license).to eq(true)
      expect(registrant_2).to be_an_instance_of(Registrant)
      expect(registrant_2.name).to eq('Penny')
      expect(registrant_2.age).to eq(15)
      expect(registrant_2.license).to eq(false)
    end
end