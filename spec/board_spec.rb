require_relative "../lib/board"

describe Board do
  describe "#initialize" do
    subject(:board_size) { described_class.new }
    it "is an 8x8 board" do
      squares_number = board_size.squares.flatten.length
      expect(squares_number).to eq(64)
    end
  end

  describe "#place_piece" do
    subject(:chess_board) { described_class.new }

    it "Place a line of pawn at line 2 and 7" do
      chess_board.place_piece
      row_2_pawn = chess_board[1].all? { |piece| piece.instance_of?(Pawn) }
      row_7_pawn = chess_board[6].all? { |piece| piece.instance_of?(Pawn) }

      expect(row_2_pawn).to be true
      expect(row_7_pawn).to be true
    end
  end
end
