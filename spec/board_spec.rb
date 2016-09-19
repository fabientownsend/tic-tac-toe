require 'spec_helper'
require 'board'

RSpec.describe Board do
  let(:board) {Board.new}

  it "should have an empty board" do
    expect(board.empty?).to be true
  end

  it "should not be empty" do
    board.set_mark(Mark::CROSS, 2)

    expect(board.empty?).to be false
  end

  it "should raise an error when it's not a int" do
    expect { board.set_mark(Mark::CROSS, "a string") }.to raise_error(ArgumentError)
  end

  it "should raise an error when you set a mark to an occupied position" do
    position = 0
    board.set_mark(Mark::CROSS, position)

    expect { board.set_mark(Mark::CROSS, position) }.to raise_error(OccupiedPositionError)
  end

  it "should raise an error when position lower than expected" do
    expect { board.set_mark(Mark::CROSS, board.POSITION_MIN - 1) }.to raise_error(OutOfRangeError)
  end

  it "should raise an error when position bigger than expected" do
    expect { board.set_mark(Mark::CROSS, board.POSITION_MAX + 1) }.to raise_error(OutOfRangeError)
  end

  it "should win for each columns" do
    columns = [[0, 3, 6], [1, 4, 7], [2, 5, 8]]

    columns.each do |array|
      board = Board.new

      array.each { |position| board.set_mark(Mark::CROSS, position) }

      expect(board.win?(Mark::CROSS)).to be true
    end
  end

  it "should win for each lines" do
    lines = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]

    lines.each do |array|
      board = Board.new

      array.each { |position| board.set_mark(Mark::CROSS, position) }

      expect(board.win?(Mark::CROSS)).to be true
    end
  end

  it "should be a win for forward diagonal" do
    [0, 4, 8].each { |position| board.set_mark(Mark::CROSS, position) }

    expect(board.win?(Mark::CROSS)).to be true
  end

  it "should be a win for backward diagonal" do
    [2, 4, 6].each { |position| board.set_mark(Mark::CROSS, position) }

    expect(board.win?(Mark::CROSS)).to be true
  end

  it "shoud be a tie" do
    [0, 2, 3, 5, 7].each { |position| board.set_mark(Mark::CROSS, position) }
    [1, 4, 6, 8].each { |position| board.set_mark(Mark::ROUND, position) }

    expect(board.tie?).to be true
  end

  it "shoud not be a tie" do
    [0, 1, 2, 3, 5, 7].each { |position| board.set_mark(Mark::CROSS, position) }
    [4, 6, 8].each { |position| board.set_mark(Mark::CROSS, position) }

    expect(board.tie?).to be false
  end
end
