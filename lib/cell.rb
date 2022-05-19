class Cell

  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate.to_s
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if !empty?
      @ship.hit unless @fired_upon == true
    end
    @fired_upon = true
  end

  def render(status = false)
    if status == true
      if !empty?
        if @ship.sunk?
          "X"
        elsif fired_upon?
          "H"
        else
          "S"
        end
      elsif fired_upon?
        "M"
      elsif !fired_upon?
        "."
      else
        "?"
      end
    else
      if !fired_upon?
        "."
      elsif empty?
        "M"
      elsif @ship.sunk?
        "X"
      elsif !@ship.sunk?
        "H"
      else
        "?"
      end
    end
  end

end
