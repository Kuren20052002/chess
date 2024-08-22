require_relative "piece"
class Queen < Piece
  def to_s
    @side == "white" ? "\u2655" : "\u265B"
  end
end
