require_relative "piece"
require "pry-byebug"
class Pawn < Piece
  attr_accessor :en_passantable

  def initialize(row, column, side)
    super
    @en_passantable = false
  end

  def valid_move?(move, board)
    result = false
    avaiable_move, avaiable_capture = legal_moves
    return false unless avaiable_move.include?(move) || avaiable_capture.include?(move)

    avaiable_move.each do |row, column|
      break if result || board[row][column] != " "

      result = true if move == [row, column] && board[row][column] == " "
    end

    avaiable_capture.each do |row, column|
      break if result

      result = true if en_passant?(move, board) # check if it can en passant other
      result = true if move == [row, column] && board[row][column] != " " && board[row][column].side != @side
    end

    check_enpassant(move, board) if result # check if itself can be en passanted
    result
  end

  def to_s
    @side == "white" ? "\u2659" : "\u265F"
  end

  def legal_moves
    move_direction = side == "white" ? 1 : -1
    start_row = side == "white" ? 1 : 6

    legal_moves = [[@row + move_direction, @column]]
    legal_moves << [@row + (2 * move_direction), @column] if @row == start_row
    legal_captures = [
      [@row + move_direction, @column + 1],
      [@row + move_direction, @column - 1]
    ]

    [legal_moves, legal_captures]
  end

  def en_passant?(move, board)
    height_difference = @side == "white" ? -1 : 1
    below_piece = board[move[0] + height_difference][move[1]]
    below_piece.instance_of?(Pawn) && below_piece.en_passantable
  end

  def check_enpassant(move, board)
    left_adjacent = board[move[0]][move[1] - 1]
    right_adjacent = board[move[0]][move[1] + 1]
    row_end = @side == "white" ? 3 : 4

    is_adjacent_pawn = left_adjacent.instance_of?(Pawn) || right_adjacent.instance_of?(Pawn)
    is_left_same_side = left_adjacent == " " ? false : left_adjacent.side != @side
    is_right_same_side = right_adjacent == " " ? false : right_adjacent.side != @side

    @en_passantable = is_adjacent_pawn && (is_left_same_side || is_right_same_side) && ((move[0] - @row).abs == 2)
  end
end
