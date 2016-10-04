require 'spec_helper'
require 'board'
require 'marks'

RSpec.describe Board do
  let(:board) {Board.new}

  it "should be free position when it never been set" do
    position = 0
    board.string_to_board("   ,   ,   ")
    expect(board.free_positions.include?(position)).to be true
  end

  it "should shouldn't get the spot after it set" do
    position = 0
    board.string_to_board("X  ,   ,   ")

    expect(board.free_positions.include?(position)).to be false
  end

  it "should be win with the first column" do
    board.string_to_board("XO ,XO ,X  ")

    expect(board.win?(Mark::CROSS)).to be true
  end

  it "should be win with the second column" do
    board.string_to_board(" XO, XO, X ")

    expect(board.win?(Mark::CROSS)).to be true
  end

  it "should be win with the thirst column" do
    board.string_to_board(" OX, OX,  X")

    expect(board.win?(Mark::CROSS)).to be true
  end

  it "should be win with the first line" do
    board.string_to_board("XXX, OO,   ")

    expect(board.win?(Mark::CROSS)).to be true
  end

  it "should be win with the second line" do
    board.string_to_board("   ,XXX,OO ")

    expect(board.win?(Mark::CROSS)).to be true
  end

  it "should be win with the third line" do
    board.string_to_board("   ,O  ,XXX")

    expect(board.win?(Mark::CROSS)).to be true
  end

  it "should be a win for forward diagonal" do
    board.string_to_board("XO ,OX ,  X")

    expect(board.win?(Mark::CROSS)).to be true
  end

  it "should be a win for backward diagonal" do
    board.string_to_board(" OX,OX ,X  ")

    expect(board.win?(Mark::CROSS)).to be true
  end

  it "shoud be a tie" do
    board.string_to_board("XOX,XOX,OXO")

    expect(board.tie?).to be true
  end

  it "shoud not be a tie" do
    board.string_to_board("XXX,XXX,XXX")

    expect(board.tie?).to be false
  end
end
