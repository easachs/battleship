require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  describe "initialize" do

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

    it "is fired upon?" do
      expect(cell.fired_upon?).to be(false)
    end

    it "can be fired upon" do
      cell.fire_upon
      expect(cell.ship.health).to eq(2)
      expect(cell.fired_upon?).to be(true)
    end

    it "cell can render" do
      cell_1 = Cell.new("B4")
      expect(cell_1.render).to eq(".")
      cell_1.fire_upon
      expect(cell_1.render).to eq("M")
    end

    it "another cell can render" do
      cell_2 = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)
      cell_2.place_ship(cruiser)
      expect(cell.render).to be(".")
      
    end
  end

  #describe "second part of test" do


  #end

end
