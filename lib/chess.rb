require_relative "board"
require_relative "player"
class Chess
  attr_reader :board

  def initialize
    @board = Board.new
    @white_player = Player.new("white")
    @black_player = Player.new("black")
    @current_player = @white_player
  end

  def checkmate?(side)
    king = side == "white" ? @board.white_king : @board.black_king
    king_pos = [king.row, king.column]
    return false unless board.check?(king_pos, side) # check if the king is in check or not

    possible_moves = king.legal_moves
    possible_moves.each do |move|
      return false if king.valid_move?(move, board) # check if can the king move to any other square

      board_copy = @board.deep_copy
      same_side_pieces = side == "white" ? board_copy.pieces("white") : board_copy.pieces(" black")
      same_side_pieces.each do |piece|
        # check if any piece can block check
        board_copy.move_piece([piece.row, piece.column], move) if piece.valid_move?(move, board_copy)
        return false unless board_copy.check?(king_pos, side)
      end
    end
    true
  end

  def new_game
  end
end
