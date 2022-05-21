
class Board

  attr_reader :cells

    def initialize
       #@rows = ["A","B","C","D"]
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
        "D4" => Cell.new("D4")

      }
    end

    def valid_coordinate?(coordinate)
      @cells.key?(coordinate)
    end

    def valid_placement?(ship, ship_coordinates)

      # equal number of coordinates/ship length?
      correct_length = ship_coordinates.length == ship.length

      coordinate_pairs = ship_coordinates.each_cons(2)
      # is ship on consecutive rows?
      consecutive_rows = coordinate_pairs.all? do |pair|
        pair[0][0] == pair[1][0] &&
        pair[0][1].to_i + 1 == pair[1][1].to_i
      end
      # is ship on consecutive columns?
      consecutive_columns = coordinate_pairs.all? do |pair|
        pair[0][0].ord + 1 == pair[1][0].ord &&
        pair[0][1] == pair[1][1]
      end
      # invalid if ship not on board
      valid_coordinates = ship_coordinates.all? do |coordinate|
        valid_coordinate?(coordinate)
      end
      # do ships overlap?
      overlap = @cells.count do |k,v|
        ship_coordinates.include?(k) && v.ship != nil
      end

      correct_length && valid_coordinates && overlap == 0 &&
      (consecutive_rows || consecutive_columns)
    end

    def place(ship, ship_coordinates)
      if valid_placement?(ship, ship_coordinates)
        ship_coordinates.each do|coordinate|
          @cells[coordinate].place_ship(ship)
        end
      else
        nil
      end
    end

    def render(status = false)
      puts "  1 2 3 4"
      a_row = "A"
      b_row = "B"
      c_row = "C"
      d_row = "D"  #"#{cells["A1"].render}
      @columns.each do |column|
        a_row.concat(" #{cells["A#{column}"].render(status)}")
        b_row.concat(" #{cells["B#{column}"].render(status)}")
        c_row.concat(" #{cells["C#{column}"].render(status)}")
        d_row.concat(" #{cells["D#{column}"].render(status)}")
      end
      puts a_row
      puts b_row
      puts c_row
      puts d_row

    end

end
