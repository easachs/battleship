require './lib/ship'
require './lib/cell'

RSpec.describe Cell do

  describe "initialize" do

    cell = Cell.new("B4")
    
    it "exists" do
      expect(cell).to be_instance_of(Cell)
    end

    it "has coordinate" do
      expect(cell.coordinate).to eq("B4")
    end

    it "has a cell ship" do
      expect(cell.ship).to be_nil
    end

    it "has empty? method" do
      expect(cell.empty?).to eq(true)
    end

    it "can place ship" do
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)
      expect(cell.ship).to eq(cruiser)
    end

    it "can be not empty" do
      expect(cell.empty?).to be(false)
    end

    it "can check fired_upon?" do
      expect(cell.fired_upon?).to be(false)
    end

    it "can be fired upon" do
      cell.fire_upon
      expect(cell.ship.health).to eq(2)
      expect(cell.fired_upon?).to be true
    end
  end

  describe "render" do

    cell_1 = Cell.new("B4")

    it "can render a blank cell" do
      expect(cell_1.render).to eq(".")
    end

    it "can render a miss" do
      cell_1.fire_upon
      expect(cell_1.render).to eq("M")
    end

    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)

    it "can render . for a cell with a ship" do
      expect(cell_2.render).to eq(".")
    end

    it "can render(true) to reveal a ship" do
      expect(cell_2.render(true)).to eq("S")
    end

    it "can render after being fired upon" do
      cell_2.fire_upon
      expect(cell_2.render).to eq("H")
      expect(cruiser.sunk?).to be false
    end

    it "can render a sunk ship" do
      cruiser.hit
      cruiser.hit
      expect(cruiser.sunk?).to be true
      expect(cell_2.render).to eq("X")
    end
  end
