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

    expect(computer.send(:best_move)).to eq(6)
  end

  it "shoudl return position that avoid computer to lose" do
    [0, 4, 2].each { |position| board.set_mark(Mark::CROSS, position) }
    [8, 3].each { |position| board.set_mark(Mark::ROUND, position) }
    computer = Computer.new(Mark::ROUND, ui, board)

    expect(computer.send(:best_move)).to eq(1)
  end

  it "should return -1 when it is lose" do
    [0, 3, 6].each { |position| board.set_mark(Mark::CROSS, position) }
    [1, 2].each { |position| board.set_mark(Mark::ROUND, position) }
    computer = Computer.new(Mark::ROUND, ui, board)

    expect(computer.send(:alphabeta, Mark::ROUND, -1000, 1000)).to eq(-1)
  end

  it "should return 1 when it is win" do
    [1, 2].each { |position| board.set_mark(Mark::CROSS, position) }
    [3, 0, 6].each { |position| board.set_mark(Mark::ROUND, position) }
    computer = Computer.new(Mark::ROUND, ui, board)

    expect(computer.send(:alphabeta, Mark::ROUND, -1000, 1000)).to eq(1)
  end

  it "should return 0 when it is a tie" do
    [0, 2, 3, 5, 7].each { |position| board.set_mark(Mark::CROSS, position) }
    [1, 4, 6, 8].each { |position| board.set_mark(Mark::ROUND, position) }
    computer = Computer.new(Mark::ROUND, ui, board)

    expect(computer.send(:alphabeta, Mark::ROUND, -1000, 1000)).to eq(0)
  end

  it "should return -1 when the other player have the possibility to win" do
    [0, 2, 4].each { |position| board.set_mark(Mark::CROSS, position) }
    [1, 3, 5].each { |position| board.set_mark(Mark::ROUND, position) }
    computer = Computer.new(Mark::ROUND, ui, board)

    expect(computer.send(:alphabeta, Mark::ROUND, -1000, 1000)).to eq(-1)
  end

  it "should return 0 when any players can win" do
    [0, 1, 5].each { |position| board.set_mark(Mark::CROSS, position) }
    [2, 3, 4].each { |position| board.set_mark(Mark::ROUND, position) }
    computer = Computer.new(Mark::ROUND, ui, board)

    expect(computer.send(:alphabeta, Mark::ROUND, -1000, 1000)).to eq(0)
  end

  it "should return 1 when computer will win in all solution" do
    [1, 3, 5].each { |position| board.set_mark(Mark::CROSS, position) }
    [0, 2, 4].each { |position| board.set_mark(Mark::ROUND, position) }
    computer = Computer.new(Mark::ROUND, ui, board)

    expect(computer.send(:alphabeta, Mark::CROSS, -1000, 1000)).to eq(1)
  end
end
