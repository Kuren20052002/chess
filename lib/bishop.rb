require_relative "piece"
class Bishop < Piece
  def valid_move?(move, board)
    directions = [[-1, -1], [-1, 1], [1, 1], [1, -1]]
    result = false
    directions.each do |row_direction, column_direction|
      row = @row
      column = @column
      loop do
        row += row_direction
        column += column_direction
        break if result || row < 0 || row > 7 || column < 0 || column > 7

        result = true if move == [row, column] && (board[row][column] == " " || board[row][column].side != @side)
        break if board[row][column] != " "
      end
    end
    result
  end

  def to_s
    @side == "white" ? "\u2657" : "\u265D"
  end
end
