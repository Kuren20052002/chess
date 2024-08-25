require_relative "piece"
class Rook < Piece
  def valid_move?(move, board)
    directions = [[0, -1], [1, 0], [0, 1], [-1, 0]]
    directions.each do |row_direction, column_direction|
      row = @row
      column = @column

      loop do
        row += row_direction
        column += column_direction
        break if row < 0 || row > 7 || column < 0 || column > 7

        return true if move == [row, column] && (board[row][column] == " " || board[row][column].side != side)
        break if board[row][column] != " "
      end
    end
    false
  end

  def to_s
    @side == "white" ? "\u2656" : "\u265C"
  end
end
