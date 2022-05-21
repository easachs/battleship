require './lib/ship'
require './lib/cell'
require './lib/board'

RSpec.describe Board do

  describe "cells" do
    board = Board.new

    it "has cells" do
      expect(board.cells).to be_a(Hash)
      expect(board.cells.size).to eq(16)
    end

    it "can validate coordinates" do
      expect(board.valid_coordinate?("A1")).to be true
      expect(board.valid_coordinate?("D4")).to be true
      expect(board.valid_coordinate?("A5")).to be false
      expect(board.valid_coordinate?("E1")).to be false
      expect(board.valid_coordinate?("A22")).to be false
    end
  end

  describe "valid_placement" do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    it "can invalidate ship placement (length)" do
      expect(board.valid_placement?(submarine, ["C3"])).to be false
      expect(board.valid_placement?(cruiser, ["A1", "A2"])).to be false
      expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])). to be false
    end

    it "can validate ship placement (length)" do
      expect(board.valid_placement?(submarine, ["B3", "C3"])).to be true
      expect(board.valid_placement?(cruiser, ["A1", "A2", "A3"])).to be true
    end

    it "can invalidate ship placement (non-consecutive columns)" do


      expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to be false
      expect(board.valid_placement?(submarine, ["A1", "C1"])).to be false
      expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to be false
      expect(board.valid_placement?(submarine, ["C1", "B1"])).to be false
    end

    it "can validate ship placement (consecutive columns)" do
      expect(board.valid_placement?(submarine, ["A1", "A2"])).to be true
      expect(board.valid_placement?(cruiser, ["B2", "B3", "B4"])).to be true
      expect(board.valid_placement?(submarine, ["D2", "D3"])).to be true
      expect(board.valid_placement?(cruiser, ["C2", "C3", "C4"])).to be true
    end

    it "can invalidate ship placement (non-consecutive rows)" do
      expect(board.valid_placement?(cruiser, ["A1", "B1", "D1"])).to be false
      expect(board.valid_placement?(submarine, ["B2", "D2"])).to be false
      expect(board.valid_placement?(cruiser, ["C1", "B1", "A1"])).to be false
      expect(board.valid_placement?(submarine, ["C2", "C1"])).to be false
    end

    it "can validate ship placement (consecutive rows)" do
      expect(board.valid_placement?(submarine, ["B1", "C1"])).to be true
      expect(board.valid_placement?(cruiser, ["A3", "B3", "C3"])).to be true
      expect(board.valid_placement?(submarine, ["C2", "D2"])).to be true
      expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to be true
    end

    it "can invalidate ship placement (no diagonals)" do
      expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to be false
      expect(board.valid_placement?(submarine, ["C2", "D3"])).to be false
      expect(board.valid_placement?(cruiser, ["B2", "C3", "D4"])).to be false
    end

    it "can invalidate ship placement (backwards/duplicate coordinates)" do
      expect(board.valid_placement?(cruiser, ["C3", "B2", "A1"])).to be false
      expect(board.valid_placement?(submarine, ["A1", "A1"])).to be false
      expect(board.valid_placement?(cruiser, ["D2", "C3", "B4"])).to be false
      expect(board.valid_placement?(submarine, ["C4", "B5"])).to be false
      expect(board.valid_placement?(cruiser, ["A3", "B3", "B3"])).to be false
      expect(board.valid_placement?(cruiser, ["A3", "B3", "B3", "C3"])).to be false
    end

    it "can invalidate off-board ship placement" do
      expect(board.valid_placement?(submarine, ["D4", "D5"])).to be false
      expect(board.valid_placement?(cruiser, ["C3", "D3", "E3"])). to be false
    end
  end

  describe "place" do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    it "can place a ship" do
      board.place(cruiser, ["A1", "A2", "A3"])
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]
      expect(cell_1.ship).to eq(cruiser)
      expect(cell_2.ship).to eq(cruiser)
      expect(cell_3.ship).to eq(cruiser)
      expect(cell_3.ship).to eq(cell_2.ship)
    end

    it "can invalidate/deny overlapping ship placement" do
      board.place(cruiser, ["A1", "A2", "A3"])
      submarine = Ship.new("Submarine", 2)
      expect(board.valid_placement?(submarine, ["A1", "B1"])).to be false
      expect(board.place(submarine, ["A1", "B2"])).to be nil
    end

  end

  describe "board render" do
    it 'renders game board' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      board.place(cruiser, ["A1", "A2", "A3"])
      board.place(submarine, ["B4", "C4"])
      expect(board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
      expect(board.render(true)).to eq("1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")
    end
  end

end
