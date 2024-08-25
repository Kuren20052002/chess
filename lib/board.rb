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

  def move_piece(pos1, pos2)
    row1, col1 = pos1
    row2, col2 = pos2
    piece = @squares[row1][col1]
    piece.column = col2
    piece.row = row2
    @squares[row2][col2] = piece
    @squares[row1][col1] = " "
  end

  def display(side = "white")
    puts "\n\n     a   b   c   d   e   f   g   h  "
    puts "   +---+---+---+---+---+---+---+---+"
    rows = side == "white" ? @squares.reverse : @squares
    rows.each_with_index do |row, idx|
      row_string = side == "white" ? "#{8 - idx}  " : "#{idx + 1}  "
      row.each do |piece|
        row_string << "| #{piece} "
      end
      puts "#{row_string}|"
      puts "   +---+---+---+---+---+---+---+---+"
    end
  end

  def check?(move, side)
    @squares.each do |row|
      row.each do |piece|
        next if piece == " " || piece.side == side || piece.instance_of?(King)

        return true if piece.valid_move?(move, self)
      end
    end
    false
  end

  def [](row, column = nil)
    column ? @squares[row][column] : @squares[row]
  end

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
    @squares[0][3] = Queen.new(0, 3, "white")
    @squares[7][3] = Queen.new(7, 3, "black")
  end

  def place_kings
    @squares[0][4] = King.new(0, 4, "white")
    @squares[7][4] = King.new(7, 4, "black")
  end
end
