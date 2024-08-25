require_relative "../lib/board"

describe Queen do
  describe "#valid_move?" do
    let(:board) { Board.new }
    subject(:white_queen) { described_class.new(4, 4, "white") }

    context "When the path have no obstruction" do
      it "return true when moving horizontally and vertically" do
        expect(white_queen.valid_move?([4, 0], board)).to be true
        expect(white_queen.valid_move?([5, 4], board)).to be true
        expect(white_queen.valid_move?([2, 4], board)).to be true
        expect(white_queen.valid_move?([4, 7], board)).to be true
      end

      it "return true when moving diagonally" do
        expect(white_queen.valid_move?([1, 1], board)).to be true
        expect(white_queen.valid_move?([6, 2], board)).to be true
        expect(white_queen.valid_move?([2, 6], board)).to be true
        expect(white_queen.valid_move?([7, 7], board)).to be true
      end

      it "return false when not in move path" do
        expect(white_queen.valid_move?([5, 6], board)).to be false
        expect(white_queen.valid_move?([1, 2], board)).to be false
        expect(white_queen.valid_move?([7, 0], board)).to be false
        expect(white_queen.valid_move?([7, 5], board)).to be false
      end
    end

    context "When there are pieces on the path" do
      before do
        board.place_piece
        board.move_piece([6, 3], [4, 3])
        board.move_piece([1, 5], [4, 5])
        board.move_piece([0, 4], [3, 4])
      end

      it "can eat the black piece and can't eat white pieces" do
        expect(white_queen.valid_move?([4, 5], board)).to be false
        expect(white_queen.valid_move?([1, 1], board)).to be false
        expect(white_queen.valid_move?([4, 3], board)).to be true
        expect(white_queen.valid_move?([6, 6], board)).to be true
      end

      it "can't jump over pieces" do
        expect(white_queen.valid_move?([4, 2], board)).to be false
        expect(white_queen.valid_move?([4, 7], board)).to be false
        expect(white_queen.valid_move?([2, 4], board)).to be false
      end
    end
  end
end
