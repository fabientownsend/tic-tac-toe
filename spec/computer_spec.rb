require 'spec_helper'
require 'computer'
require 'board'

RSpec.describe Computer do
  it "should give a random number" do
    input = StringIO.new("1\n")
    output = StringIO.new
    ui = CliInterface.new(input, output)
    board = Board.new
    computer = Computer.new("X", ui, board)

    move = computer.next_move

    expect(move).to be >= 0
    expect(move).to be <= 8
  end
end
