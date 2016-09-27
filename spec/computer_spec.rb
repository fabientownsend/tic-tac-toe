require 'spec_helper'
require 'computer'
require 'board'

RSpec.describe Computer do
  let (:input) { StringIO.new("1\n") }
  let (:output) { StringIO.new }
  let (:ui) { CliInterface.new(input, output, "spec/lang/") }
  let (:board) { Board.new }

  it "should return position that make the computer win" do
    [0, 1, 5].each { |position| board.set_mark(Mark::CROSS, position) }
    [2, 3, 4].each { |position| board.set_mark(Mark::ROUND, position) }
    computer = Computer.new(Mark::ROUND, ui, board)

    expect(computer.next_move).to eq(6)
  end

  it "should return the position which block the other palyer to win" do
    [0, 4, 2].each { |position| board.set_mark(Mark::CROSS, position) }
    [8, 3].each { |position| board.set_mark(Mark::ROUND, position) }
    computer = Computer.new(Mark::ROUND, ui, board)

    expect(computer.next_move).to eq(1)
  end
end
