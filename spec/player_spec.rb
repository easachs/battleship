require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/player'

# Some of the methods in this class interact
# with the CLI/terminal using gets/puts. Player
# class was partially tested on the terminal
# and in pry.

RSpec.describe Player do

  player = Player.new

  it "can initialize" do
    expect(player).to be_an_instance_of(Player)
  end

  it "starts with no board" do
    expect(player.player_board).to be_nil
  end

  it "starts with 2 ships" do
    expect(player.player_ship_count).to eq(2)
  end

  it "can create a 4x4 board" do
    player.create_board
    expect(player.player_board.cells.count).to eq(16)
  end

  it "can create a 9x9 board" do
    player.create_board(9,9)
    expect(player.player_board.cells.count).to eq(81)
  end

  it "can render an untouched cell" do
    player.create_board
    expect(player.player_board.cells["A1"].render).to eq('.')
  end

  it "starts with an untouched board" do
    expect(player.player_board.render).not_to include('X')
    expect(player.player_board.render).not_to include('S')
    expect(player.player_board.render).not_to include('M')
    expect(player.player_board.render).not_to include('H')
    expect(player.player_board.render).to include('.')
  end

  it "can render a miss" do
    player.player_board.cells["A1"].fire_upon
    expect(player.player_board.cells["A1"].render).to eq('M')
  end

  it "can render a hit" do
    sub = Ship.new("Submarine", 2)
    player.player_board.place(sub, ["A1", "A2"])
    player.player_board.cells["A1"].fire_upon
    expect(player.player_board.cells["A1"].render).to eq('H')
  end

  it "can reset ship count" do
    expect(player.reset).to eq(2)
  end

end
