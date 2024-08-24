require_relative "../lib/board"

describe Pawn do
  describe "#legal_moves" do
    context "when the pawn is on its initial position" do
      subject(:white_pawn) { described_class.new(1, 6, "white") }
      subject(:black_pawn) { described_class.new(6, 5, "black") }
      it "white pawn can move up 1 or 2 squares" do
        expect(white_pawn.legal_moves).to include([[2, 6], [3, 6]])
      end

      it "black pawn can move down 1 or 2 squares" do
        expect(black_pawn.legal_moves).to include([[5, 5], [4, 5]])
      end
    end

    context "when the pawn has moved" do
      subject(:white_pawn) { described_class.new(3, 2, "white") }
      subject(:black_pawn) { described_class.new(4, 3, "black") }
      it "white pawn can move up 1 square" do
        expect(white_pawn.legal_moves).to eq([[[4, 2]], [[4, 3], [4, 1]]])
      end

      it "black pawn can move down 1 square" do
        expect(black_pawn.legal_moves).to eq([[[3, 3]], [[3, 4], [3, 2]]])
      end
    end
  end

  describe "#valid_move?" do
    let(:board) { Board.new }
    context "when the move is valid with no obstruction" do
      subject(:white_pawn) { described_class.new(1, 6, "white") }
      subject(:black_pawn) { described_class.new(6, 5, "black") }
      it "return true" do
        expect(white_pawn.valid_move?([3, 6], board)).to be true
        expect(black_pawn.valid_move?([4, 5], board)).to be true
      end
    end

    context "when the move is valid with obstruction" do
      subject(:white_pawn) { described_class.new(3, 2, "white") }
      subject(:black_pawn) { described_class.new(6, 3, "black") }
      before do
        board.place_piece
        board.move_piece([6, 2], [4, 2])
        board.move_piece([1, 3], [5, 3])
      end
      it "white pawn can not move" do
        expect(white_pawn.valid_move?([4, 2], board)).to be false
      end

      it "black pawn can not move" do
        expect(black_pawn.valid_move?([5, 3], board)).to be false
        expect(black_pawn.valid_move?([4, 3], board)).to be false
      end
    end

    context "when the move is a capture but the capture squares are empty" do
      subject(:white_pawn) { described_class.new(3, 2, "white") }
      subject(:black_pawn) { described_class.new(6, 3, "black") }
      it "return false" do
        expect(white_pawn.valid_move?([4, 3], board)).to be false
        expect(white_pawn.valid_move?([4, 1], board)).to be false
      end

      it "return false" do
        expect(black_pawn.valid_move?([5, 2], board)).to be false
        expect(black_pawn.valid_move?([5, 4], board)).to be false
      end
    end

    context "when the move is a capture" do
      subject(:white_pawn) { described_class.new(3, 2, "white") }
      subject(:black_pawn) { described_class.new(6, 3, "black") }
      before do
        board.place_piece
        board.move_piece([6, 2], [4, 3])
        board.move_piece([1, 3], [5, 2])
      end
      it "white pawn can capture" do
        expect(white_pawn.valid_move?([4, 3], board)).to be true
      end

      it "black pawn can capture" do
        expect(black_pawn.valid_move?([5, 4], board)).to be false
        expect(black_pawn.valid_move?([5, 2], board)).to be true
      end
    end
  end
end
