require 'spec_helper'
require 'computer'
require 'board'

RSpec.describe Computer do
  let (:input) { StringIO.new("1\n") }
  let (:output) { StringIO.new }
  let (:ui) { CliInterface.new(input, output, "spec/lang/") }
  let (:board) { Board.new }

  it "the computer will move to block its opponent" do
    board.new_board("|OOX|
                     |XXO|
                     |   |")

    computer = Computer.new(Mark::ROUND, ui, board)

    expect(computer.next_move).to eq(6)
  end

  it "the computer will move to win" do
    board.new_board("|XXO|
                     |OO |
                     |   |")

    computer = Computer.new(Mark::ROUND, ui, board)

    expect(computer.next_move).to eq(5)
  end
end
