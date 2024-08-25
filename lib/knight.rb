require_relative "piece"
class Knight < Piece
  def initialize(row, column, side)
    super
    @moveset = [[-1, -2], [-2, -1], [1, -2], [2, -1], [2, 1], [1, 2], [-1, 2], [-2, 1]]
  end

  def legal_moves
    legal_moves = []
    @moveset.each do |row, column|
      result_row = @row + row
      result_column = @column + column
      next if result_row < 0 || result_row > 7 || result_column < 0 || result_column > 7

      legal_moves << [result_row, result_column]
    end
    legal_moves
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
