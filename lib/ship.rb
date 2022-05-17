class Ship
  attr_reader = :name, :length

  def initialize (name, length)
    @name = name
    @length = length
    @health = length
  end

  def sunk? (sunk)
    @health == 0
  end
end
