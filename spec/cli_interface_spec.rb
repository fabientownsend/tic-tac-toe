require 'cli_interface'

RSpec.describe CliInterface do
  it "should display the board" do
    board = [1, 2, 3]
    board_result = " 1 | 2 | 3 \n"
    @input = StringIO.new
    @output = StringIO.new
    @interface = CliInterface.new(@input, @output)

    @interface.display_board(board)

    expect(@output.string).to eq(board_result)
  end
end
