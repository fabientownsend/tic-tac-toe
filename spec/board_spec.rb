require 'spec_helper'
require 'board'

RSpec.describe Board do
  let(:board) {Board.new}

  it "should have an empty board" do
    expect(board.empty?).to be true
  end

  it "should set the mark at the position 8" do
    board.set_mark("X", 2)

    expect(board.empty?).to be false
  end

  it "should raise an error when it's not a int" do
    expect { board.set_mark("X", "a string") }.to raise_error(ArgumentError)
  end

  it "should tell the position isn't free" do
    position = 0
    board.set_mark("X", position)

    expect { board.set_mark("X", position) }.to raise_error(OccupiedSpotError)
  end

  it "should raise an error when position lower than expected" do
    expect { board.set_mark("X", -1) }.to raise_error(OutOfRangeError)
  end

  it "should raise an error when position bigger than expected" do
    expect { board.set_mark("X", 9) }.to raise_error(OutOfRangeError)
  end

  it "should be a win_colum for colum 1" do
    expect(board.win?("X")).to be false
  end

  it "should win for each columns" do
    [[0, 3, 6], [1, 4, 7], [2, 5, 8]].each do |array|
      board = Board.new

      array.each { |a| board.set_mark("X", a) }

      expect(board.win?("X")).to be true
    end
  end

  it "should win for each lines" do
    [[0, 1, 2], [3, 4, 5], [6, 7, 8]].each do |array|
      board = Board.new

      array.each { |a| board.set_mark("X", a) }

      expect(board.win?("X")).to be true
    end
  end

  it "should be a for diagonal 1" do
    [0, 4, 8].each { |a| board.set_mark("X", a) }

    expect(board.win?("X")).to be true
  end

  it "should be a for diagonal 2" do
    [2, 4, 6].each { |a| board.set_mark("X", a) }

    expect(board.win?("X")).to be true
  end

  it "shoud be a tie" do
    board.set_mark("X", 0)
    board.set_mark("X", 2)
    board.set_mark("X", 3)
    board.set_mark("X", 5)
    board.set_mark("X", 7)

    board.set_mark("O", 1)
    board.set_mark("O", 4)
    board.set_mark("O", 6)
    board.set_mark("O", 8)

    expect(board.tie?).to be true
  end

  it "shoud not be a tie" do
    board.set_mark("X", 0)
    board.set_mark("X", 1)
    board.set_mark("X", 2)
    board.set_mark("X", 3)
    board.set_mark("O", 4)
    board.set_mark("X", 5)
    board.set_mark("O", 6)
    board.set_mark("X", 7)
    board.set_mark("O", 8)

    expect(board.tie?).to be false
  end
end
