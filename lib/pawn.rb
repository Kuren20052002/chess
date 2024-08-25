require_relative "piece"
class Pawn < Piece
  attr_reader :en_passantable

  def initialize(row, column, side)
    super
    @en_passantable = false
  end

  def valid_move?(move, board)
    result = false
    avaiable_move, avaiable_capture = legal_moves
    result = false unless avaiable_move.include?(move) && avaiable_capture.include?(move)

    avaiable_move.each do |row, column|
      break if result || board[row][column] != " "

      result = true if move == [row, column] && board[row][column] == " "
    end

    avaiable_capture.each do |row, column|
      break if result

      result = true if move == [row, column] && board[row][column] != " " && board[row][column].side != @side
    end
    @en_passantable = move == avaiable_move[1] if result
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
end
