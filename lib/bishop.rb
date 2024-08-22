require_relative "piece"
class Bishop < Piece
  def to_s
    @side == "white" ? "\u2657" : "\u265D"
  end
end
