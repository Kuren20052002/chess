class Player
  attr_reader :side

  def initialize(side)
    @side = side
  end

  def make_move
    command = gets.chomp.downcase
    start, destination = command.split
    until valid_move?(start) && valid_move?(destination)
      return [command, false] if valid_command?(command)

      puts "Please input a valid square on the board or a valid command"
      command = gets.chomp.downcase
      start, destination = command.split
    end

    [translate_pos(start), translate_pos(destination)]
  end

  private

  def valid_command?(cmd)
    return false unless cmd

    ["board", "help", "save", "quit", "o-o-o", "o-o"].include?(cmd)
  end

  def valid_move?(move)
    return false unless move

    move.match?(/^[a-h][1-8]$/)
  end

  def translate_pos(pos)
    [pos[1].to_i - 1, pos[0].ord - 97]
  end
end
