class Computer

  attr_reader :computer_board,
              :computer_ship_count

  def initialize
    @computer_board = nil
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_sub = Ship.new("Submarine", 2)
    @computer_ship_count = 2
  end

  def create_board(height_input = 4, width_input = 4)
    @computer_board = Board.new(height_input, width_input)
  end

  def computer_placement
    generated_coordinates = []
    loop = @computer_board.place(@computer_cruiser, generated_coordinates)

    until loop != nil
    @computer_cruiser.length.times do
        generated_coordinates << @computer_board.cells.to_a.sample(1).flatten[0]
      end

      loop = @computer_board.place(@computer_cruiser, generated_coordinates)
      generated_coordinates = []
    end

    loop = @computer_board.place(@computer_sub, generated_coordinates)

    until loop != nil
    @computer_sub.length.times do
        generated_coordinates << @computer_board.cells.to_a.sample(1).flatten[0]
      end

      loop = @computer_board.place(@computer_sub, generated_coordinates)
      generated_coordinates = []
    end
  end

  def player_turn
    puts "Enter the coordinate for your shot:"
    player_shot = gets.chomp.upcase.strip
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

  def reset
    @computer_ship_count = 2
  end

end
