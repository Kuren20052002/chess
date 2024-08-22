require_relative "piece"
class Rook < Piece
  def to_s
    @side == "white" ? "\u2656" : "\u265C"
  end
end
