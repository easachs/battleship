require './lib/ship.rb'

RSpec.describe Ship do
  it 'exists' do
    cruiser = Ship.new("Cruiser", 3)
  end

  it "is sunk?" do
    sunk = Ship.new("Cruiser", 0)
  end
end
