require_relative "../lib/king"

describe King do
  describe "#legal_moves" do
    subject(:white_king) { described_class.new(0, 4, "white") }
    subject(:black_king) { described_class.new(7, 4, "white") }
    context "when board is empty" do
      it "white king return all surrounding squares" do
        expect(white_king.legal_moves).to match_array([[0, 3], [0, 5], [1, 4], [1, 5], [1, 3]])
      end

      it "black king return all surrounding squares" do
        expect(black_king.legal_moves).to match_array([[7, 3], [7, 5], [6, 4], [6, 5], [6, 3]])
      end
    end
  end

  describe "#valid_move?" do
    let(:board) { Board.new }
    context "when board is empty" do
      subject(:white_king) { described_class.new(0, 4, "white") }
      it "return false when move is unreachable" do
        expect(white_king.valid_move?([2, 4], board)).to be false
      end

      it "return true when move is unreachable" do
        expect(white_king.valid_move?([1, 3], board)).to be true
      end
    end

    context "When the board has every piece except the pawns" do
      subject(:white_king) { described_class.new(5, 2, "white") }
      before do
        board.place_rooks
        board.place_bishops
        board.place_horses
        board.place_queens
        board.place_kings
      end
      it "can't move to targeted square" do
        expect(white_king.valid_move?([6, 2], board)).to be false
        expect(white_king.valid_move?([4, 3], board)).to be false
        expect(white_king.valid_move?([6, 3], board)).to be false
      end

      it "can move to untargeted square" do
        expect(white_king.valid_move?([4, 1], board)).to be true
      end

      it "white king can't go on white pieces but can with black pieces" do
        board.move_piece([7, 3], [5, 1])
        board.move_piece([0, 3], [4, 3])
        expect(white_king.valid_move?([5, 1], board)).to be true
        expect(white_king.valid_move?([4, 3], board)).to be false
      end
    end
  end
end
