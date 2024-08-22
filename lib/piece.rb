class Piece
  attr_accessor :x, :y

  def initialize(row, column, side)
    @x = column
    @y = row
    @side = side
  end
end
