
class Board

  attr_reader :cells

    def initialize
      @rows = ["A","B","C","D"]
      @columns = [1, 2, 3, 4]

      @cells = {
        "A1" => Cell.new("A1"),
        "A2" => Cell.new("A2"),
        "A3" => Cell.new("A3"),
        "A4" => Cell.new("A4"),
        "B1" => Cell.new("B1"),
        "B2" => Cell.new("B2"),
        "B3" => Cell.new("B3"),
        "B4" => Cell.new("B4"),
        "C1" => Cell.new("C1"),
        "C2" => Cell.new("C2"),
        "C3" => Cell.new("C3"),
        "C4" => Cell.new("C4"),
        "D1" => Cell.new("D1"),
        "D2" => Cell.new("D2"),
        "D3" => Cell.new("D3"),
        "D4" => Cell.new("D4"),
      }
    end

    def valid_coordinate?(coordinate)
      @cells.key?(coordinate)
    end

    def valid_placement?(ship, ship_coordinates)
      correct_length = ship_coordinates.length == ship.length
      coordinate_pairs = ship_coordinates.each_cons(2)

      consecutive_rows = coordinate_pairs.all? do |coordinate_pair|
        coordinate_pair[0][0] == coordinate_pair[1][0] && coordinate_pair[0][1].to_i + 1 == coordinate_pair[1][1].to_i
      end

      consecutive_columns = coordinate_pairs.all? do |pair| do|coordinate|
        valid_coordinate?(coordinate)
      end

      overlap =
      correct_length && valid_coordinates && (consecutive_rows || consecutive_columns)
      end


    def place(ship, coordinates)
      coordinates.map do|coordinate|
        @cells[coordinate].place_ship(ship)
      end
    end

end
