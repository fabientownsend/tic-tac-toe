require 'cli_interface'

RSpec.describe CliInterface do
  it "should display the line" do
    board = [1, 2, 3]
    board_result = " 1 | 2 | 3 \n"
    @input = StringIO.new
    @output = StringIO.new
    @interface = CliInterface.new(@input, @output)

    @interface.display_line(board)

    expect(@output.string).to eq(board_result)
  end

  it "should display the board" do
    board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    board_result = " 1 | 2 | 3 \n 4 | 5 | 6 \n 7 | 8 | 9 \n"
    @input = StringIO.new
    @output = StringIO.new
    @interface = CliInterface.new(@input, @output)

    @interface.display_board(board)

    expect(@output.string).to eq(board_result)
  end
end
