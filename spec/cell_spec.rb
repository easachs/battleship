require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  cell = Cell.new("B4")
  it 'exists' do
    expect(cell).to be_instance_of(Cell)
  end

  it 'has coordinate' do
    expect(cell.coordinate).to eq("B4")
  end

  it "has a cell ship" do
    expect(cell.ship).to be_nil
  end

  it "has a cell empty" do
    expect(cell.empty?).to eq(true)
  end

  it "has cruiser ship" do
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    expect(cell.ship).to eq(cruiser)
  end

  it "place cruiser on cell" do
    expect(cell.empty?).to be(false)
  end

end
