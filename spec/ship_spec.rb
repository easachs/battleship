require './lib/ship.rb'

RSpec.describe Ship do
  it 'exists' do
    cruiser = Ship.new("Cruiser", 3)
    expect(cruiser).to be_a(Ship)
  end
  it "cruiser has attributes" do 
    cruiser = Ship.new("Cruiser", 3)
    sunk = Ship.new("Cruiser", 3)
    expect(cruiser.sunk?).to eq(false)
  end

  it "when hit" do
    cruiser = Ship.new("Cruiser", 3)
    sunk = Ship.new("Cruiser", 3)
    hit = Ship.new("Cruiser", 2)
    expect(cruiser.hit).to eq(2)
  end

end
