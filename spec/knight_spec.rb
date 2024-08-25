require_relative "../lib/board"

describe Knight do
  describe "#legal_moves" do
    context "when the knight is on its initial position" do
      subject(:white_knight) { described_class.new(0, 1, "white") }
      subject(:black_knight) { described_class.new(7, 6, "black") }
      it "can jump around" do
        expect(white_knight.legal_moves).to include([2, 0], [2, 2], [1, 3])
        expect(black_knight.legal_moves).to include([5, 5], [5, 7], [6, 4])
      end
    end
  end

  describe "#valid_move?" do
    let(:board) { Board.new }

    before do
      board.place_piece
    end

    context "when the input is random number" do
      subject(:white_knight) { described_class.new(0, 1, "white") }
      it "return false" do
        expect(white_knight.valid_move?([7, 2], board)).to be false
        expect(white_knight.valid_move?([4, 0], board)).to be false
        expect(white_knight.valid_move?([3, 8], board)).to be false
        expect(white_knight.valid_move?([5, 9], board)).to be false
      end
    end

    context "when knight is on the initial square" do
      subject(:white_knight) { described_class.new(0, 1, "white") }
      it "can jump over pawn" do
        expect(white_knight.valid_move?([2, 2], board)).to be true
      end
    end

    context "when there are obstruction" do
      subject(:white_knight) { described_class.new(4, 0, "white") }
      before do
        board.move_piece([1, 2], [5, 2])
      end

      it "can eat black pawn" do
        expect(white_knight.valid_move?([6, 1], board)).to be true
      end

      it "can't eat white pawn" do
        expect(white_knight.valid_move?([5, 2], board)).to be false
      end
    end
  end
end
