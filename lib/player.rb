class Player
  attr_reader :side

  def initialize(side)
    @side = side
  end

  def make_move
    start = gets.chomp.downcase
    until valid_move?(start)
      puts "Please input a valid square on the board"
      start = gets.chomp.downcase
    end

    endo = gets.chomp.downcase
    until valid_move?(endo)
      puts "Please input a valid square on the board"
      endo = gets.chomp.downcase
    end
    [translate_pos(start), translate_pos(endo)]
  end

  private

  def valid_move?(move)
    move.match?(/^[a-h][1-8]$/)
  end

  def translate_pos(pos)
    [pos[0].ord - 97, pos[1].to_i - 1]
  end
end
