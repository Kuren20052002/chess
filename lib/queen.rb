require_relative "piece"
class Queen < Piece
  def valid_move?(move, board)
    directions = [[0, -1], [1, 0], [0, 1], [-1, 0], [-1, -1], [1, -1], [1, 1], [-1, 1]]
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
    @side == "white" ? "\u2655" : "\u265B"
  end
end
