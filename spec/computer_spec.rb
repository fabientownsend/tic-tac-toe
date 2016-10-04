require 'spec_helper'
require 'computer'
require 'board'

RSpec.describe Computer do
  let (:input) { StringIO.new("1\n") }
  let (:output) { StringIO.new }
  let (:ui) { CliInterface.new(input, output, "spec/lang/") }
  let (:board) { Board.new }

  it "the computer will move to block its opponent" do
    board.string_to_board("OOX,XXO,   ")

    computer = Computer.new(Mark::ROUND, ui, board)

    board.set_mark(computer.mark, computer.next_move)
    expect(board.to_s).to eq("OOX,XXO,O  ")
  end

  it "the computer will move to win" do
    board.string_to_board("XXO,OO ,   ")

    computer = Computer.new(Mark::ROUND, ui, board)

    board.set_mark(computer.mark, computer.next_move)
    expect(result).to eq(expected)
    expect(board.to_s).to eq("XXO,OOO,   ")
  end
end
