require_relative "../lib/chess"

describe Chess do
  subject(:chess) { described_class.new }

  describe "#checkmate?" do
    before do
      chess.board.place_piece
    end
    context "when checkmate is occurring" do
      it "returns true when the king is checkmated with no legal moves" do
        chess.board.move_piece([0, 4], [6, 3]) # Example move causing checkmate
        expect(chess.checkmate?("white")).to be true
      end

      it "returns true when the king is checkmated with no pieces to block or capture the attacking piece" do
        chess.board.move_piece([7, 4], [5, 4])
        chess.board.move_piece([0, 3], [4, 4])
        chess.board.move_piece([0, 2], [1, 1])
        expect(chess.checkmate?("black")).to be true
      end

      it "returns true when the king is in checkmate due to a lack of escape squares" do
        chess.board.move_piece([0, 4], [1, 4])
        chess.board.move_piece([0, 0], [0, 4])
        chess.board.move_piece([7, 3], [3, 4])
        expect(chess.checkmate?("white")).to be true
      end
    end

    context "when not in checkmate" do
      it "returns false when the king is in check but has a legal move" do
        chess.board.move_piece([0, 4], [1, 4])
        chess.board.move_piece([0, 0], [0, 4])
        chess.board.move_piece([7, 3], [3, 6])
        expect(chess.checkmate?("white")).to be false
      end

      it "returns false when the king is in check but a piece can block the check" do
        chess.board.move_piece([0, 4], [1, 4])
        chess.board.move_piece([0, 0], [0, 4])
        chess.board.move_piece([7, 3], [3, 4])
        chess.board.move_piece([0, 3], [1, 3])
        chess.board.move_piece([0, 7], [0, 3])
        expect(chess.checkmate?("white")).to be false
      end

      it "returns false when the king is not in check" do
        chess.board.move_piece([0, 4], [5, 2])
        expect(chess.checkmate?("white")).to be false
      end
    end
  end

  describe "stalemate" do
    before do
      chess.board[0][7] = King.new(0, 7, "white")
      chess.board[7][7] = King.new(7, 7, "black")
      chess.board[1][5] = Queen.new(1, 5, "black")
    end
    context "when white is in stalemate" do
      it "return true" do
        expect(chess.stalemate?("black")).to be true
      end
    end

    context "when white has a moveable piece" do
      it "return false" do
        chess.board[1][1] = Queen.new(7, 7, "white")
        expect(chess.stalemate?("black")).to be false
      end
    end
  end
end
