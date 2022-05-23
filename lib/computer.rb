class Computer

  attr_reader :computer_board,
              :computer_cruiser,
              :computer_sub

  def initialize
    @computer_board = nil
    @computer_cruiser = nil
    @computer_sub = nil
  end

  def create_board(height_input = 4, width_input = 4)
    @computer_board = Board.new(height_input, width_input)
  end

  def computer_placement
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_sub = Ship.new("Submarine", 2)

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

  # def computer_turn
  #   computer_shot = player_board.cells.to_a.sample(1).flatten[0]
  #   duplicate_shot = player_board.cells["#{computer_shot}"].render != "."
  #   if !duplicate_shot
  #     player_board.cells["#{computer_shot}"].fire_upon
  #     if player_board.cells["#{computer_shot}"].render == "X"
  #       puts "The computer sunk your #{player_board.cells["#{computer_shot}"].ship.name}!"
  #       player_ship_count -= 1
  #     elsif player_board.cells["#{computer_shot}"].render == "H"
  #       puts "The computer's shot on #{computer_shot} was a hit."
  #     elsif player_board.cells["#{computer_shot}"].render == "M"
  #       puts "The computer's shot on #{computer_shot} was a miss."
  #     end
  #   else
  #     computer_turn
  #   end
  # end

end
