class Player

  attr_reader :player_board,
              :player_ship_count

  def initialize
    @player_board = nil
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_sub = Ship.new("Submarine", 2)
    @player_ship_count = 2
  end

  def create_board(height_input = 4, width_input = 4)
    @player_board = Board.new(height_input, width_input)
  end

  def cruiser_placement
    puts "Enter the cells for the Cruiser (3 spaces):"
    cruiser_input = gets.chomp.upcase.split(" ")
    place_cruiser = @player_board.place(@player_cruiser, ["#{cruiser_input[0]}", "#{cruiser_input[1]}", "#{cruiser_input[2]}"])
    if place_cruiser == nil
      puts "Those are invalid coordinates. Please try again."
      cruiser_placement
    else
      puts @player_board.render(true)
      puts "\n"
    end
  end

  def sub_placement
    puts "Enter the cells for the Submarine (2 spaces):"
    sub_input = gets.chomp.upcase.split(" ")
    place_sub = @player_board.place(@player_sub, ["#{sub_input[0]}", "#{sub_input[1]}"])
    if place_sub == nil
      puts "Those are invalid coordinates. Please try again."
      sub_placement
    else
      puts @player_board.render(true)
    end
  end

  def computer_turn
    computer_shot = @player_board.cells.to_a.sample(1).flatten[0]
    duplicate_shot = @player_board.cells["#{computer_shot}"].render != "."
    if !duplicate_shot
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

  def reset
    @player_ship_count = 2
  end

end
