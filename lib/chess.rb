require_relative "board"
require_relative "player"
require_relative "game_text"
require "pry-byebug"

class Chess
  attr_reader :board

  include GameMessages
  def initialize
    @board = Board.new
    @white_player = Player.new("white")
    @black_player = Player.new("black")
    @current_player = @white_player
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
    handle_move(GameMessages::MAKE_MOVE_PROMPT) { true }
  end

  # to handle turn when in check
  def handle_check
    handle_move("You're being checked") do |piece_pos, piece_end|
      !check_for_check_if([piece_pos, piece_end], @current_player.side)
    end
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

  private

  def handle_move(prompt, &move_prevent_check)
    @board.display(@current_player.side)
    puts prompt

    piece_pos, piece_end, piece = retrieve_piece_and_position
    return @board.en_passant([piece_pos, piece_end], @current_player.side) if en_passant?(piece_end)

    until piece
      return nil if execute_command(piece_pos) # Ignore the wrong name for command variable

      puts prompt
      piece_pos, piece_end, piece = retrieve_piece_and_position
    end

    until piece && valid_piece?(piece, piece_end) && move_prevent_check.call([piece_pos, piece_end])
      return @board.en_passant([piece_pos, piece_end], @current_player.side) if en_passant?(piece_end)

      puts GameMessages::INVALID_MOVE_MESSAGE
      piece_pos, piece_end, piece = retrieve_piece_and_position
    end

    @board.move_piece(piece_pos, piece_end)
  end

  def execute_command(cmd)
    case cmd
    when "save"
      puts "This feature has not been implemented yet."
      true
    when "help"
      puts GameMessages::INSTRUCTIONS
      false
    when "board"
      @board.display
      false
    when "o-o-o"
      if can_casle?("long")
        @board.castle_long(@current_player.side)
        true
      else
        puts "Can't castle on Queen side"
        false
      end
    when "o-o"
      if can_casle?("short")
        @board.castle_short(@current_player.side)
        true
      else
        puts "Can't castle on King side"
        false
      end
    when "quit"
      puts "See you next time"
      exit(0)
    end
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
    board_copy.move_piece(moves[0], moves[1])
    board_copy.check?(king_pos, side)
  end

  def en_passant?(move)
    binding.pry
    opponent_piece_height = @current_player.side == "white" ? -1 : 1
    move_to_empty_square = @board[move[0]][move[1]] == " "
    is_opponent_side_pawn = @board[move[0] + opponent_piece_height][move[1]].instance_of?(Pawn) &&
                            @board[move[0] + opponent_piece_height][move[1]].side != @current_player.side

    move_to_empty_square && is_opponent_side_pawn
  end

  def can_casle?(castle_side)
    range_start, range_end = castle_side == "long" ? [1, 3] : [5, 6]
    rook_column = castle_side == "long" ? 0 : 7
    king = @current_player.side == "white" ? @board.white_king : @board.black_king
    rook = @board[king.row][rook_column]

    return false if king.moved && rook.moved

    (range_start..range_end).each do |column|
      return false if @board[king.row][column] != " " ||
                      (column != 1 && @board.check?([king.row, column], @current_player.side))
    end
    true
  end

  def valid_piece?(piece, piece_end)
    piece != " " && piece.side == @current_player.side && piece.valid_move?(piece_end, @board)
  end

  def retrieve_piece_and_position
    piece_pos, piece_end = @current_player.make_move
    piece = @board[piece_pos[0]][piece_pos[1]] if piece_end
    [piece_pos, piece_end, piece]
  end

  def change_turn
    @current_player = @current_player == @white_player ? @black_player : @white_player
  end
end
