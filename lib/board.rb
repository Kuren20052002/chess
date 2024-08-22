require_relative "pawn"

class Board
  attr_reader :squares

  def initialize(board = Array.new(8) { Array.new(8, nil) })
    @squares = board
  end

  def place_piece
    place_pawns
  end

  def [](row, column = nil)
    column ? @squares[row][column] : @squares[row]
  end

  private

  def place_pawns
    [1, 6].each do |row|
      side = row == 1 ? "white" : "black"
      (0..7).each do |column|
        @squares[row][column] = Pawn.new(row, column, side)
      end
    end
  end
end
