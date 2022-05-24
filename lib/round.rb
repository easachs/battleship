require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer'
require './lib/player'

class Round

  def initialize
    @player = nil
    @computer = nil
  end

  def start
    @player = Player.new
    @computer = Computer.new
    puts "\nWelcome to BATTLESHIP\nEnter p to play. Enter q to quit."
    menu_input = gets.chomp.to_s.downcase
    if menu_input[0] == "q"
      puts "You quit the game."
    elsif menu_input[0] != "p"
      puts "Invalid."
      start
    elsif menu_input[0] == "p"
      game_steps
    end
  end

  def welcome
    puts "Enter desired grid dimensions:"
    puts "How many rows would you like?"
    height_input = gets.chomp.to_i
    puts "How many columns would you like?"
    width_input = gets.chomp.to_i

    height_input = 4 if height_input <= 0
    width_input = 4 if width_input <= 0
    @player.create_board(height_input, width_input)
    @computer.create_board(height_input, width_input)

    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts @player.player_board.render(true)
  end

  def shows_boards
    puts "\n========== COMPUTER BOARD =========="
    puts @computer.computer_board.render
    puts "=========== PLAYER BOARD ==========="
    puts @player.player_board.render(true)
    puts "\n"
  end

  def results
    if @computer.computer_ship_count == 0
      "Your opponent has no remaining ships. You win!"
    elsif @player.player_ship_count == 0
      "You have no remaining ships. Try again sailor."
    end
  end

  def reset
    @player.reset
    @computer.reset
  end

  def game_steps
    welcome
    @player.cruiser_placement
    @player.sub_placement
    @computer.computer_placement
    until @computer.computer_ship_count == 0 ||
    @player.player_ship_count == 0
      shows_boards
      @computer.player_turn
      @player.computer_turn
    end
    shows_boards
    puts results
    reset
    start
  end
end
