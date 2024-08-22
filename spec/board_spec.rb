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
    before do
      chess_board.place_piece
    end

    it "Place a line of pawn at line 2 and 7" do
      [1, 6].each do |row|
        pawns_count = chess_board[row].count { |piece| piece.instance_of?(Pawn) }
        expect(pawns_count).to eq(8)
      end
    end

    it "Place 4 Rooks at the corner" do
      [[0, 0], [0, 7], [7, 0], [7, 7]].each do |row, column|
        expect(chess_board[row][column]).to be_instance_of(Rook)
        puts row + column
      end
    end

    it "Place 4 Bishops" do
      [[0, 2], [0, 5], [7, 2], [7, 5]].each do |row, column|
        expect(chess_board[row][column]).to be_instance_of(Bishop)
        puts row + column
      end
    end

    it "Place 4 Horses" do
      [[0, 1], [0, 6], [7, 1], [7, 6]].each do |row, column|
        expect(chess_board[row][column]).to be_instance_of(Knight)
        puts row + column
      end
    end

    it "Place 2 Queens" do
      [[0, 3], [7, 3]].each do |row, column|
        expect(chess_board[row][column]).to be_instance_of(Queen)
        puts row + column
      end
    end

    it "Place 2 Kings" do
      [[0, 4], [7, 4]].each do |row, column|
        expect(chess_board[row][column]).to be_instance_of(King)
        puts row + column
      end
    end
  end
end
