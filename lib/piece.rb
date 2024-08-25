class Piece
  attr_accessor :row, :column, :side

  def initialize(row, column, side)
    @column = column
    @row = row
    @side = side
  end

  def valid_move?
    raise NoMethodError("Override this implementation")
  end
end
