require_relative "piece"
class Knight < Piece
  def to_s
    @side == "white" ? "\u2658" : "\u265E"
  end
end
