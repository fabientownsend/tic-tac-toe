require 'cli_interface'

RSpec.describe CliInterface do
  it "should display the board" do
    @input = StringIO.new("a\nb\nexit\n")
    @output  = StringIO.new
    @server = CliInterface.new(@input, @output)
    expect(@server.display_board(1)).to eq("test")
  end
end
