class Player
  attr_reader :side

  def initialize(side)
    @side = side
  end

  def make_move
    start, destination = gets.chomp.downcase.split
    until valid_move?(start) && valid_move?(destination)
      puts "Please input a valid square on the board"
      start, destination = gets.chomp.downcase.split
    end

    [translate_pos(start), translate_pos(destination)]
  end

  private

  def valid_move?(move)
    return false unless move

    move.match?(/^[a-h][1-8]$/)
  end

  def translate_pos(pos)
    [pos[1].to_i - 1, pos[0].ord - 97]
  end
end
