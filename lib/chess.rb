require_relative "board"
require_relative "player"
require_relative "game_text"

class Chess
  attr_reader :board

  include GameMessages
  def initialize
    @board = Board.new
    @white_player = Player.new("white")
    @black_player = Player.new("black")
    @current_player = @white_player
  end

  def checkmate?(side)
    king = side == "white" ? @board.white_king : @board.black_king
    king_pos = [king.row, king.column]
    return false unless @board.check?(king_pos, side) # check if the king is in check or not

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
    @board.place_piece
    puts GameMessages::INSTRUCTIONS
    loop do
      check_for_check(@current_player.side) ? handle_check : handle_turn
      opponent_side = @current_player.side == "white" ? "black" : "white"
      if checkmate?(opponent_side)
        puts GameMessages::GAME_ENDING_TEXT
        break
      end
      change_turn
    end
  end

  def handle_turn
    @board.display(@current_player.side)
    puts MAKE_MOVE_PROMPT
    piece_pos, piece_end = @current_player.make_move
    piece = @board[piece_pos[0]][piece_pos[1]]
    until piece != " " && piece.side == @current_player.side && piece.valid_move?(piece_end, @board)
      puts GameMessages::INVALID_MOVE_MESSAGE
      piece_pos, piece_end = @current_player.make_move
      piece = @board[piece_pos[0]][piece_pos[1]]
    end
    @board.move_piece(piece_pos, piece_end)
  end

  # to handle turn when in check
  def handle_check
    @board.display(@current_player.side)
    puts "You're being check"
    piece_pos, piece_end = @current_player.make_move
    piece = @board[piece_pos[0]][piece_pos[1]]
    until piece != " " && piece.side == @current_player.side &&
          !check_for_check_if([piece_pos, piece_end], @current_player.side) && piece.valid_move?(piece_end, @board)
      puts "Please block or move out of check"
      piece_pos, piece_end = @current_player.make_move
      piece = @board[piece_pos[0]][piece_pos[1]]
    end
    @board.move_piece(piece_pos, piece_end)
  end

  # this fuction is for checking the current state of board
  def check_for_check(side)
    king = side == "white" ? @board.white_king : @board.black_king
    king_pos = [king.row, king.column]
    @check = @board.check?(king_pos, side)
    @check
  end

  # this fuction is for checking the state of board if a move is made
  def check_for_check_if(moves, side)
    king = side == "white" ? @board.white_king : @board.black_king
    king_pos = [king.row, king.column]
    board_copy = @board.deep_copy
    puts "#{moves[0]} and #{moves[1]}"
    board_copy.move_piece(moves[0], moves[1])
    board_copy.display
    puts board_copy.check?(king_pos, side)
  end

  def change_turn
    @current_player = @current_player == @white_player ? @black_player : @white_player
  end
end
