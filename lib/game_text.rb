module GameMessages
  # Introduction message when the game starts
  INTRODUCTION = <<~INTRO
    Welcome to Chess!

    In this game, you'll compete against another player. Each player starts with 16 pieces, and the goal is to checkmate your opponent's king.

    Let's get started!

    Please choose an option:
    1 - Start a new game
    2 - Load an existing game
  INTRO

  # Instructions for the player
  INSTRUCTIONS = <<~INSTRUCTIONS
    Here are the basic rules:
    - Move your pieces according to their unique movement patterns.
    - To make a move, enter the starting and ending positions of the piece (e.g., 'e2 e4').
    - Type 'board' to see the board.
    - Type 'help' to get instrucstions.
    - Type 'quit' to exit the game at any time.
    - Type 'O-O-O' to castle long.
    - Type 'O-O' to castle short.
    - Type 'save' to save current game if you have business to take care of.
    - If you are in check, you must make a move to get out of check.
    - If you checkmate your opponent, you win the game!

    Good luck and have fun!
  INSTRUCTIONS

  # Prompt the player to make a move
  MAKE_MOVE_PROMPT = "It's your turn. Please make a move (e.g., 'e2 e4'):"

  # When the player make an invalid move
  INVALID_MOVE_MESSAGE = "The move you selected is against the rules or is not valid."

  # Text to display when the game ends (win, lose, or draw)
  GAME_ENDING_TEXT = <<~ENDING
    Checkmate!
    That was a really good game.
    Thank both players for playing!

    If you'd like to play again, just start a new game.
  ENDING

  # Message to display in case of stalemate
  STALEMATE_TEXT = <<~STALEMATE
    Stalemate! The game is a draw.

    No legal moves left player, and the king is not in check.
    Good game!
  STALEMATE
end
