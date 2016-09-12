require 'cli_interface'

RSpec.describe CliInterface do
  before(:each) do
    @input = StringIO.new("1\n")
    @output = StringIO.new
    @interface = CliInterface.new(@input, @output)
  end

  it "should display the line" do
    board = [0, 1, 2]
    board_result = " 0 | 1 | 2 \n"

    @interface.display_line(board)

    expect(@output.string).to eq(board_result)
  end

  it "should display the board" do
    board = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
    board_result = " 0 | 1 | 2 \n 3 | 4 | 5 \n 6 | 7 | 8 \n"

    @interface.display_board(board)

    expect(@output.string).to eq(board_result)
  end

  it "should display text when ask for the next move" do
    @interface.next_move
    expect(@output.string).to eq("What is your next move? ")
  end

  it "should return the next move of the player" do
    expect(@interface.next_move).to eq(1)
  end
end
