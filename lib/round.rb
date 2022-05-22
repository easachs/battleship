class Round

  def initialize
    @player_board = nil
    @computer_board = nil
    @player_ship_count = 2
    @computer_ship_count = 2
  end

  def start
    @player_ship_count = 2
    @computer_ship_count = 2
    puts "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit."
    menu_input = gets.chomp.to_s.downcase
    if menu_input == "q"
      puts "You quit the game."
    elsif menu_input != "p"
      puts "Invalid."
      start
    elsif menu_input == "p"
      game_steps
    end
  end

  def welcome
    @player_board = Board.new
    @computer_board = Board.new
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts @player_board.render(true)
  end

  def computer_placement
    computer_cruiser = Ship.new("Cruiser", 3)
    computer_sub = Ship.new("Submarine", 2)

    generated_coordinates = []
    loop = @computer_board.place(computer_cruiser, generated_coordinates)

    until loop != nil
      computer_cruiser.length.times do
        generated_coordinates << @computer_board.cells.to_a.sample(1).flatten[0]
      end

      loop = @computer_board.place(computer_cruiser, generated_coordinates)
      generated_coordinates = []
    end

    loop = @computer_board.place(computer_sub, generated_coordinates)

    until loop != nil
    computer_sub.length.times do
        generated_coordinates << @computer_board.cells.to_a.sample(1).flatten[0]
      end

      loop = @computer_board.place(computer_sub, generated_coordinates)
      generated_coordinates = []
    end
  end

  def cruiser_placement
    player_cruiser = Ship.new("Cruiser", 3)
    puts "Enter the cells for the Cruiser (3 spaces):"
    cruiser_input = gets.chomp.upcase.split(" ")
    place_cruiser = @player_board.place(player_cruiser, ["#{cruiser_input[0]}", "#{cruiser_input[1]}", "#{cruiser_input[2]}"])
    if place_cruiser == nil
      puts "Those are invalid coordinates. Please try again."
      cruiser_placement
    else
      puts @player_board.render(true)
      puts "\n"
    end
  end

  def sub_placement
    player_sub = Ship.new("Submarine", 2)
    puts "Enter the cells for the Submarine (2 spaces):"
    sub_input = gets.chomp.upcase.split(" ")
    place_sub = @player_board.place(player_sub, ["#{sub_input[0]}", "#{sub_input[1]}"])
    if place_sub == nil
      puts "Those are invalid coordinates. Please try again."
      sub_placement
    else
      puts @player_board.render(true)
    end
  end

  def shows_boards
    puts "\n========== COMPUTER BOARD =========="
    puts @computer_board.render
    puts "=========== PLAYER BOARD ==========="
    puts @player_board.render(true)
    puts "\n"
  end

  def player_turn
    puts "Enter the coordinate for your shot:"
    player_shot = gets.chomp.upcase
    if @computer_board.valid_coordinate?(player_shot)
      if @computer_board.cells["#{player_shot}"].fired_upon?
        puts "You cannot fire upon the same cell twice."
        player_turn
      else
        @computer_board.cells["#{player_shot}"].fire_upon
        if @computer_board.cells["#{player_shot}"].render == "X"
          puts "You sunk a #{@computer_board.cells["#{player_shot}"].ship.name}!"
          @computer_ship_count -= 1
        elsif @computer_board.cells["#{player_shot}"].render == "H"
          puts "Your shot on #{player_shot} was a hit!"
        elsif @computer_board.cells["#{player_shot}"].render == "M"
          puts "Your shot on #{player_shot} was a miss."
        end
      end
    else
      puts "Invalid coordinate."
      player_turn
    end
  end

  def computer_turn
    computer_shot = @player_board.cells.to_a.sample(1).flatten[0]
    # past_computer_shots = []
    duplicate_shot = @player_board.cells["#{computer_shot}"].render != "."
    if !duplicate_shot
      # past_computer_shots << computer_shot
      @player_board.cells["#{computer_shot}"].fire_upon
      if @player_board.cells["#{computer_shot}"].render == "X"
        puts "The computer sunk your #{@player_board.cells["#{computer_shot}"].ship.name}!"
        @player_ship_count -= 1
      elsif @player_board.cells["#{computer_shot}"].render == "H"
        puts "The computer's shot on #{computer_shot} was a hit."
      elsif @player_board.cells["#{computer_shot}"].render == "M"
        puts "The computer's shot on #{computer_shot} was a miss."
      end
    else
      computer_turn
    end
  end

  def results
    if @computer_ship_count == 0
      puts "Your opponent has no remaining ships. You win!"
      puts "\n"
    elsif @player_ship_count == 0
      puts "You have no remaining ships. Try again sailor."
      puts "\n"
    end
  end

  def game_steps
    welcome
    cruiser_placement
    sub_placement
    computer_placement
    until @computer_ship_count == 0 || @player_ship_count == 0
      shows_boards
      player_turn
      computer_turn
    end
    shows_boards
    results
    start
  end
end
