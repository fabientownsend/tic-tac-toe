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

  it "should give a array with free position" do
    input = StringIO.new("1\n")
    output = StringIO.new
    ui = CliInterface.new(input, output)
    board = Board.new
    board.set_mark("X", 0)
    board.set_mark("X", 1)
    board.set_mark("X", 2)
    board.set_mark("X", 3)
    board.set_mark("X", 4)
    board.set_mark("X", 5)
    board.set_mark("X", 6)
    board.set_mark("X", 7)
    computer = Computer.new("X", ui, board)

    expect(computer.next_move).to eq(8)
  end


  it "should be nil when these is any spot free" do
    input = StringIO.new("1\n")
    output = StringIO.new
    ui = CliInterface.new(input, output)
    board = Board.new
    board.set_mark("X", 0)
    board.set_mark("X", 1)
    board.set_mark("X", 2)
    board.set_mark("X", 3)
    board.set_mark("X", 4)
    board.set_mark("X", 5)
    board.set_mark("X", 6)
    board.set_mark("X", 7)
    board.set_mark("X", 8)
    computer = Computer.new("X", ui, board)

    expect(computer.next_move).to eq(nil)
  end
end
