require_relative "piece"
class King < Piece
  attr_reader :moved

  def initialize(row, column, side)
    super
    @moved = false
  end

  def legal_moves
    legal_moves = []
    moves = [[0, -1], [1, -1], [1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1]]
    moves.each do |row, column|
      result_row = @row + row
      result_column = @column + column
      next if result_row < 0 || result_row > 7 || result_column < 0 || result_column > 7

      legal_moves << [result_row, result_column]
    end
    legal_moves
  end

  def valid_move?(move, board)
    board_copy = board.deep_copy
    board_copy.move_piece([@row, @column], move) if board[move[0]]
    return false if board_copy.check?(move, @side)

    result = false
    moves = legal_moves
    moves.each do |row, column|
      next if result

      if move == [row, column] && (board[row][column] == " " || board[row][column].side != side)
        @moved = true if result
        return true
      end
    end
    false
  end

  def to_s
    @side == "white" ? "\u2654" : "\u265A"
  end
end
