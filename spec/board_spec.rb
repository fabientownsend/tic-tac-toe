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

  it "should tell the position isn't free" do
    position = 0
    board.set_mark("X", position)

    expect(board.is_free?(position)).to be false
  end

  it "should tell the position is free" do
    position = 0

    expect(board.is_free?(position)).to be true
  end

  it "should tell false when it lower than 0" do
    expect(board.is_valid?(-1)).to be false
  end

  it "should tell false when it bigger than sqr(board)" do
    expect(board.is_valid?(9)).to be false
  end

  it "should be a win_colum for colum 1" do
    expect(board.win?("X")).to be false
  end

  it "should be a win_colum for colum 1" do
    board.set_mark("X", 0)
    board.set_mark("X", 3)
    board.set_mark("X", 6)

    expect(board.win?("X")).to be true
  end

  it "should be a win_colum for colum 2" do
    board.set_mark("X", 1)
    board.set_mark("X", 4)
    board.set_mark("X", 7)

    expect(board.win?("X")).to be true
  end

  it "should be a win_colum for colum 3" do
    board.set_mark("X", 2)
    board.set_mark("X", 5)
    board.set_mark("X", 8)

    expect(board.win?("X")).to be true
  end

  it "should be a for line 1" do
    board.set_mark("X", 0)
    board.set_mark("X", 1)
    board.set_mark("X", 2)

    expect(board.win?("X")).to be true
  end

  it "should be a for line 2" do
    board.set_mark("X", 3)
    board.set_mark("X", 4)
    board.set_mark("X", 5)

    expect(board.win?("X")).to be true
  end

  it "should be a for line 3" do
    board.set_mark("X", 6)
    board.set_mark("X", 7)
    board.set_mark("X", 8)

    expect(board.win?("X")).to be true
  end

  it "should be a for diagonal 1" do
    board.set_mark("X", 0)
    board.set_mark("X", 4)
    board.set_mark("X", 8)

    expect(board.win?("X")).to be true
  end
  it "should be a for diagonal 2" do
    board.set_mark("X", 2)
    board.set_mark("X", 4)
    board.set_mark("X", 6)

    expect(board.win?("X")).to be true
  end
end
