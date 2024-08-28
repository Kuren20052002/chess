require_relative "../lib/player"

describe Player do
  describe "make_move" do
    subject(:new_player) { described_class.new("white") }
    context "When input correct" do
      it "Translate position into array cord" do
        allow(new_player).to receive(:gets).and_return("a1 f6")
        result = new_player.make_move
        expect(result).to eq([[0, 0], [5, 5]])
      end

      it "Translate position into array cord" do
        allow(new_player).to receive(:gets).and_return("d5 g2")
        result = new_player.make_move
        expect(result).to eq([[4, 3], [1, 6]])
      end
    end

    context "When input wrong twice for both gets" do
      it "puts error 2 times" do
        error_text = "Please input a valid square on the board or a valid command"
        allow(new_player).to receive(:gets).and_return("b22 h8", "ab2 h1", "a1 a2")
        expect(new_player).to receive(:puts).with(error_text).twice
        new_player.make_move
      end
    end

    context "When input wrong 3 times" do
      it "puts error 3 times" do
        error_text = "Please input a valid square on the board or a valid command"
        allow(new_player).to receive(:gets).and_return("u123 i12", "asdf", "a2 i9", "h2 a1")
        expect(new_player).to receive(:puts).with(error_text).exactly(3).times
        new_player.make_move
      end
    end

    context "When input command" do
      it "return command when input correctly" do
        allow(new_player).to receive(:gets).and_return("save")
        expect(new_player.make_move).to eq(["save", false])
      end

      it "return command when input correctly" do
        allow(new_player).to receive(:gets).and_return("o-o-o")
        expect(new_player.make_move).to eq(["o-o-o", false])
      end

      it "return command when input correctly" do
        allow(new_player).to receive(:gets).and_return("help")
        expect(new_player.make_move).to eq(["help", false])
      end
    end
  end
end
