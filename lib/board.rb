require_relative "pawn"
require_relative "rook"
require_relative "knight"
require_relative "bishop"
require_relative "queen"
require_relative "king"

class Board
  attr_reader :squares, :white_king, :black_king

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
    if @squares[row1][col1] != " "
      piece = @squares[row1][col1]
      piece.column = col2
      piece.row = row2
      @squares[row2][col2] = piece
    end
    @squares[row1][col1] = " "
  end

  def display(side = "white")
    puts "\n\n   +---+---+---+---+---+---+---+---+"
    rows = side == "white" ? @squares.reverse : @squares
    rows.each_with_index do |row, idx|
      row_string = side == "white" ? "#{8 - idx}  " : "#{idx + 1}  "
      row.each do |piece|
        row_string << "| #{piece} "
      end
      puts "#{row_string}|"
      puts "   +---+---+---+---+---+---+---+---+"
    end
    puts "     a   b   c   d   e   f   g   h  "
  end

  def check?(move, side)
    opposite_pieces = side == "white" ? pieces("black") : pieces("white")
    opposite_pieces.each do |piece|
      return true if piece.valid_move?(move, self)
    end
    false
  end

  def castle_long
    move_piece([0, 4], [0, 2])
    move_piece([0, 0], [0, 3])
  end

  def castle_short
    move_piece([0, 4], [0, 6])
    move_piece([0, 7], [0, 5])
  end

  def [](row, column = nil)
    column ? @squares[row][column] : @squares[row]
  end

  def pieces(side)
    pieces = []
    @squares.each do |row|
      row.each do |piece|
        next if piece == " " || piece.side != side

        pieces << piece
      end
    end
    pieces
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
    @white_king = King.new(0, 4, "white")
    @black_king = King.new(7, 4, "black")
    @squares[0][4] = @white_king
    @squares[7][4] = @black_king
  end

  def deep_copy
    Marshal.load(Marshal.dump(self))
  end
end
