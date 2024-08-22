require_relative "piece"
class King < Piece
  def to_s
    @side == "white" ? "\u2654" : "\u265A"
  end
end
