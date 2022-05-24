require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer'

# Some of the methods in this class interact
# with the CLI/terminal using gets/puts. Computer
# class was partially tested on the terminal
# and in pry.

RSpec.describe Computer do

  computer = Computer.new

  it "can initialize" do
    expect(computer).to be_an_instance_of(Computer)
  end

  it "starts with no board" do
    expect(computer.computer_board).to be_nil
  end

  it "starts with 2 ships" do
    expect(computer.computer_ship_count).to eq(2)
  end

  it "can create a 4x4 board" do
    computer.create_board
    expect(computer.computer_board.cells.count).to eq(16)
  end

  it "can create a 9x9 board" do
    computer.create_board(9,9)
    expect(computer.computer_board.cells.count).to eq(81)
  end

  it "can render an untouched cell" do
    expect(computer.computer_board.cells["A1"].render).to eq('.')
  end

  it "can render a miss" do
    computer.computer_board.cells["A1"].fire_upon
    expect(computer.computer_board.cells["A1"].render).to eq('M')
  end

  it "can place boats" do
    computer.create_board
    computer.computer_placement
    expect(computer.computer_board.render(true)).to include('S')
  end

  it "can hide boats" do
    expect(computer.computer_board.render).not_to include('S')
  end

  it "can reset ship count" do
    expect(computer.reset).to eq(2)
  end

end
