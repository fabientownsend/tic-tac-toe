require 'spec_helper'
require 'board'

RSpec.describe Board do
  let(:board) {Board.new}

  it "should return all the position" do
    expect(board.board).to eq([[0, 1, 2], [3, 4, 5], [6, 7, 8]])
  end

  it "should be free position when it never been set" do
    position = 0
    expect(board.free_positions.include?(position)).to be true
  end

  it "should shouldn't get the spot after it set" do
    position = 0
    board.set_mark(Mark::CROSS, position)
    expect(board.free_positions.include?(position)).to be false
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
