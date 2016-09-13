require 'cli_interface'
require 'board'

RSpec.describe CliInterface do
  let(:input) {StringIO.new("1\n")}
  let(:output) {StringIO.new}
  let(:interface) {CliInterface.new(input, output)}

  it "should display the board" do
    board = Board.new
    board_result = " 0 | 1 | 2 \n 3 | 4 | 5 \n 6 | 7 | 8 \n"

    interface.display_board(board.board)

    expect(output.string).to eq(board_result)
  end

  it "should display text when ask for the next move" do
    interface.next_move("X")
    expect(output.string).to eq("X what is your next move? ")
  end

  it "should return the next move of the player" do
    expect(interface.next_move("X")).to eq("1\n")
  end

  it "should display the message when position occupied" do
    interface.occupied_position
    expect(output.string).to eq("This position isn't free\n")
  end

  it "should display the message when position out of range" do
    interface.position_range
    expect(output.string).to eq("The value have to be an integer between 0 and 8\n")
  end

  it "should display the winner" do
    interface.winner("X")
    expect(output.string).to eq("The winner is: X!\n")
  end

  it "should display tie result" do
    interface.tie
    expect(output.string).to eq("It's a tie!\n")
  end
end
