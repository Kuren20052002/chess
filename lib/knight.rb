require_relative "piece"
class Knight < Piece
  def initialize(row, column, side)
    super
    @moveset = [[-1, -2], [-2, -1], [1, -2], [2, -1], [2, 1], [1, 2], [-1, 2], [-2, 1]]
  end

  def legal_moves
    legal_moves = @moveset.map do |row, column|
      [(@row + row), (@column + column)]
    end
  end

  def valid_move?(move, board)
    moves = legal_moves
    moves.each do |row, column|
      return true if move == [row, column] && (board[row][column] == " " || board[row][column].side != @side)
    end
    false
  end

  def to_s
    @side == "white" ? "\u2658" : "\u265E"
  end
end
