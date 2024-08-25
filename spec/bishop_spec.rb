require_relative "../lib/board"

describe Bishop do
  let(:board) { Board.new }
  describe "#valid_move?" do
    let(:board) { Board.new }
    context "When move is invalid" do
      subject(:white_bishop) { described_class.new(4, 3, "white") }
      it "return false" do
        expect(white_bishop.valid_move?([2, 4], board)).to be false
        expect(white_bishop.valid_move?([2, 0], board)).to be false
        expect(white_bishop.valid_move?([5, 1], board)).to be false
      end
    end

    context "When move is valid" do
      subject(:white_bishop) { described_class.new(4, 3, "white") }
      it "return true" do
        expect(white_bishop.valid_move?([2, 4], board)).to be false
        expect(white_bishop.valid_move?([4, 5], board)).to be false
        expect(white_bishop.valid_move?([1, 1], board)).to be false
      end
    end

    context "When move is valid" do
      subject(:white_bishop) { described_class.new(4, 3, "white") }
      it "return true" do
        expect(white_bishop.valid_move?([7, 6], board)).to be true
        expect(white_bishop.valid_move?([5, 2], board)).to be true
        expect(white_bishop.valid_move?([1, 0], board)).to be true
        expect(white_bishop.valid_move?([2, 5], board)).to be true
      end
    end

    context "When there's something blocking the way" do
      subject(:white_bishop) { described_class.new(4, 4, "white") }
      before do
        board.place_piece
        board.move_piece([1, 3], [3, 3])
      end
      it "Bishop can't go on or over the piece of the same color" do
        expect(white_bishop.valid_move?([3, 3], board)).to be false
        expect(white_bishop.valid_move?([1, 1], board)).to be false
      end

      it "Bishop can capture piece of different color but not over it" do
        expect(white_bishop.valid_move?([6, 2], board)).to be true
        expect(white_bishop.valid_move?([7, 1], board)).to be false
      end
    end
  end
end
