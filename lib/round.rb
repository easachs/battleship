class Round
#'ord' issue relating to board.rb line 47
  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_sub = Ship.new("Submarine", 2)
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_sub = Ship.new("Submarine", 2)

  end
  def start
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play or q to quit."
    menu_input = gets.chomp
    if menu_input == "p"
      puts " You chose #{menu_input}, Let's play!"
      puts "I have laid out my ships on the grid."
      puts "You now need to lay out your two ships."
      puts "The Cruiser is three units long and the Submarine is two units long."
      puts @player_board.render(true)
      game_steps

    else
      puts "Game has quit."
    end
  end

  def cruiser_placement
    puts "Enter the squares for the Cruiser (3 spaces): "
    cruiser_input = gets.chomp.upcase.split(" ")
    ok_cruiser_spot = @player_board.place(@player_cruiser,["#{cruiser_input[0]}", "#{cruiser_input[1]}", "#{cruiser_input[2]}"])
    if ok_cruiser_spot == nil
      puts "Those are invalid coordinates. Please try again: "
      cruiser_placement
    else
      puts @player_board.render(true)

    end

  end

  def sub_placement
    puts "Enter the squares for the Submarine (2 spaces): "
    sub_input = gets.chomp.upcase.split(" ")
    ok_sub_spot = @player_board.place(@player_sub,["#{sub_input[0]}", "#{sub_input[1]}"])
    if ok_sub_spot == nil
      puts "Those are invalid coordinates. Please try again: "
      sub_placement
    else
      puts @player_board.render(true)
    end

  end

  def computer_ship_placement
    @computer_board.place(@computer_sub,["A2", "A3"])
    @computer_board.place(@computer_cruiser,["D1", "D2", "D3"])
  end

  def shows_both_boards
    puts "=============COMPUTER BOARD============="
    puts @computer_board.render
    puts "==============PLAYER BOARD=============="
    puts @player_board.render(true)
  end

  def player_turn

    puts "Enter a coordinate to fire upon: "

    player_shot = gets.chomp.upcase
      if @computer_board.valid_coordinate?(player_shot)
        if @computer_board.cells["#{player_shot}"].fired_upon?
          puts "Duplicate shot, choose another."
          player_turn
        #elsif !@computer_board.valid_coordinate?(player_shot)
        #  puts "Please enter valid coordinate."
        #  player_turn
        else
          @computer_board.cells["#{player_shot}"].fire_upon
          if @computer_board.cells["#{player_shot}"].render == "X"
            puts "You sunk a #{@computer_board.cells["#{player_shot}"].ship.name}"
          elsif @computer_board.cells["#{player_shot}"].render == "H"
            puts "Your shot on #{player_shot} was a hit."
          elsif @computer_board.cells["#{player_shot}"].render == "M"
            puts "Your shot on #{player_shot} was a miss."
          end
        end
      else
        puts "Invalid coordinate, try again"
        player_turn
      end

  end

  def final_results
    if (@computer_cruiser.sunk? && @computer_sub.sunk?)
      puts "You won!"

    else (@player_cruiser.sunk? && @player_sub.sunk?)
      puts "You lose. Try again sailor"
    end
  end

  def game_steps
    cruiser_placement
    sub_placement
    computer_ship_placement
    until (@player_cruiser.sunk? && @player_sub.sunk?) || (@computer_cruiser.sunk? && @computer_sub.sunk?)
      shows_both_boards
      player_turn
    end
    shows_both_boards
    final_results
    start
  end
end
