class Board

  attr_reader :cells

    def initialize(row_count = 4, column_count = 4)
       @cells = {}
       number_to_letter = (1..26).zip("A".."Z").to_h

      # limit max size of board
      row_count = 26 if row_count > 26
      row_count = 3 if row_count < 3
      column_count = 9 if column_count > 9
      column_count = 3 if column_count < 3

      # create rows and columns
      @rows = (number_to_letter[1]..number_to_letter[row_count]).to_a
      # @rows = ["A","B","C","D"]
      @columns = (1..column_count).to_a
      # @columns = [1,2,3,4]

      # create cells
      @rows.each do |row|
        @columns.each do |column|
          @cells["#{row}#{column}"] = Cell.new("#{row}#{column}")
        end
      end
    end

    def valid_coordinate?(coordinate)
      @cells.key?(coordinate)
    end

    def valid_placement?(ship, ship_coordinates)
      # invalid if not on board
      valid_coordinates = ship_coordinates.all? do |coordinate|
        valid_coordinate?(coordinate)
      end

      if valid_coordinates
        # equal number of coordinates/ship length?
        correct_length = ship_coordinates.length == ship.length

        coordinate_pairs = ship_coordinates.each_cons(2)
        # is ship on consecutive rows?
        consecutive_rows = coordinate_pairs.all? do |pair|
          pair[0][0] == pair[1][0] &&
          pair[0][-1].to_i + 1 == pair[-1][-1].to_i
        end
        # is ship on consecutive columns?
        consecutive_columns = coordinate_pairs.all? do |pair|
          pair[0][0].ord + 1 == pair[-1][0].ord &&
          pair[0][-1] == pair[-1][-1]
        end
        # do ships overlap?
        overlap = @cells.count do |k,v|
          ship_coordinates.include?(k) && v.ship != nil
        end

        correct_length && overlap == 0 &&
        (consecutive_rows || consecutive_columns)
      else
        false
      end
    end

    def place(ship, ship_coordinates)
      if valid_placement?(ship, ship_coordinates)
        ship_coordinates.each do |coordinate|
          @cells[coordinate].place_ship(ship)
        end
      else
        nil
      end
    end

    def render(status = false)
      render_columns = " "
      @columns.each do |column|
        render_columns.concat(" #{column}")
      end

      render_rows = ""
      group_by_rows = @cells.group_by do |k,v|
        k[0]
      end
      group_by_rows.each do |k,v|
        render_rows.concat("#{k}")
        v.each do |cell|
          render_rows.concat(" #{cell[1].render(status)}")
        end
        render_rows.concat(" \n")
        # puts render_rows
      end
      output = "#{render_columns} \n#{render_rows}"

      # columns = "  1 2 3 4"
      # a_row = "A"
      # b_row = "B"
      # c_row = "C"
      # d_row = "D"
      # @columns.each do |column|
      #   a_row.concat(" #{cells["A#{column}"].render(status)}")
      #   b_row.concat(" #{cells["B#{column}"].render(status)}")
      #   c_row.concat(" #{cells["C#{column}"].render(status)}")
      #   d_row.concat(" #{cells["D#{column}"].render(status)}")
      # end
      #
      # output = "#{columns} \n#{a_row} \n#{b_row} \n#{c_row} \n#{d_row} \n"
    end

end
