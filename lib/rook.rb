require_relative "piece"
class Rook < Piece
  attr_reader :moved

  def initialize(row, column, side)
    super
    @moved = false
  end

  def valid_move?(move, board)
    directions = [[0, -1], [1, 0], [0, 1], [-1, 0]]
    directions.each do |row_direction, column_direction|
      row = @row
      column = @column

      loop do
        row += row_direction
        column += column_direction
        break if row < 0 || row > 7 || column < 0 || column > 7

        if move == [row, column] && (board[row][column] == " " || board[row][column].side != side)
          @moved = true if result
          return true
        end
        break if board[row][column] != " " # break if there is a piece in the way and not the intended move
      end
    end

    false
  end

  def to_s
    @side == "white" ? "\u2656" : "\u265C"
  end
end
