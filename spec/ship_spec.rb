require './lib/ship.rb'

RSpec.describe Ship do
  
  cruiser = Ship.new("Cruiser", 3)
  
  it "is a Ship" do
     expect(cruiser.class).to be(Ship)
   end
  
  it "has a name" do
    expect(cruiser.name).to eq("Cruiser")
  end

  it "has a length" do
    expect(cruiser.length).to eq(3)
  end

  it 'has health' do
    expect(cruiser.health).to eq(3)
  end

  it "has sunk?" do
    expect(cruiser.sunk?).to be(false)
  end

  it "can be hit" do
    cruiser.hit
    expect(cruiser.health).to eq(2)
    expect(cruiser.sunk?).to be(false) 
  end 
  
  it "can be sunk" do
    cruiser.hit
    expect(cruiser.health).to eq(1)
    expect(cruiser.sunk?).to be(false)
    cruiser.hit
    expect(cruiser.sunk?).to be(true)
  end

end
