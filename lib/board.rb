require_relative "pawn"
require_relative "rook"
require_relative "knight"
require_relative "bishop"
require_relative "queen"
require_relative "king"

class Board
  attr_reader :squares

  def initialize(board = Array.new(8) { Array.new(8, " ") })
    @squares = board
  end

  def place_piece
    place_pawns
    place_rooks
    place_horses
    place_bishops
    place_queens
    place_kings
  end

  def display
    puts "\n\n    a   b   c   d   e   f   g   h  "
    puts "   +---+---+---+---+---+---+---+---+"
    @squares.each_with_index do |row, idx|
      row_string = "#{idx}  "
      row.each do |piece|
        row_string << "| #{piece} "
      end
      puts "#{row_string}|"
      puts "   +---+---+---+---+---+---+---+---+"
    end
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

  def place_rooks
    [[0, 0], [0, 7], [7, 0], [7, 7]].each do |row, column|
      side = row == 0 ? "white" : "black"
      @squares[row][column] = Rook.new(row, column, side)
    end
  end

  def place_bishops
    [[0, 2], [0, 5], [7, 2], [7, 5]].each do |row, column|
      side = row == 0 ? "white" : "black"
      @squares[row][column] = Bishop.new(row, column, side)
    end
  end

  def place_horses
    [[0, 1], [0, 6], [7, 1], [7, 6]].each do |row, column|
      side = row == 0 ? "white" : "black"
      @squares[row][column] = Knight.new(row, column, side)
    end
  end

  def place_queens
    [[0, 3], [7, 3]].each do |row, column|
      side = row == 0 ? "white" : "black"
      @squares[row][column] = Queen.new(row, column, side)
    end
  end

  def place_kings
    [[0, 4], [7, 4]].each do |row, column|
      side = row == 0 ? "white" : "black"
      @squares[row][column] = King.new(row, column, side)
    end
  end
end

board = Board.new
board.place_piece
board.display
