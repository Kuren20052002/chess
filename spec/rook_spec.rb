require_relative "../lib/board"

describe Rook do
  describe "#valid_move?" do
    let(:board) { Board.new }
    before do
      board.place_piece
    end

    subject(:white_rook) { described_class.new(4, 4, "white") }

    context "When the path have no obstruction" do
      it "return true" do
        expect(white_rook.valid_move?([4, 0], board)).to be true
        expect(white_rook.valid_move?([5, 4], board)).to be true
        expect(white_rook.valid_move?([2, 4], board)).to be true
        expect(white_rook.valid_move?([4, 7], board)).to be true
      end
    end

    context "When there are pieces on the path" do
      before do
        board.move_piece([6, 3], [4, 3])
        board.move_piece([1, 5], [4, 5])
      end

      it "can eat the black piece and can't eat white pieces" do
        expect(white_rook.valid_move?([4, 5], board)).to be false
        expect(white_rook.valid_move?([4, 3], board)).to be true
      end

      it "can't jump over pieces" do
        expect(white_rook.valid_move?([4, 2], board)).to be false
        expect(white_rook.valid_move?([4, 7], board)).to be false
      end
    end
  end
end
