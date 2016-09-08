require 'cli_interface'

RSpec.describe CliInterface do
  it "should display the line" do
    board = [0, 1, 2]
    board_result = " 0 | 1 | 2 \n"
    @input = StringIO.new
    @output = StringIO.new
    @interface = CliInterface.new(@input, @output)

    @interface.display_line(board)

    expect(@output.string).to eq(board_result)
  end

  it "should display the board" do
    board = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
    board_result = " 0 | 1 | 2 \n 3 | 4 | 5 \n 6 | 7 | 8 \n"
    @input = StringIO.new
    @output = StringIO.new
    @interface = CliInterface.new(@input, @output)

    @interface.display_board(board)

    expect(@output.string).to eq(board_result)
  end
end
