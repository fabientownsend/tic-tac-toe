require 'board'

RSpec.describe BoardGame do
  before(:each) do
    @board_game = BoardGame.new
  end

  it "should have an empty board" do
    board_expected = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]

    expect(@board_game.board).to eq(board_expected)
  end

  it "should give the column position" do
    expect(@board_game.get_column(0)).to eq(0)
    expect(@board_game.get_column(1)).to eq(1)
    expect(@board_game.get_column(2)).to eq(2)
    expect(@board_game.get_column(3)).to eq(0)
    expect(@board_game.get_column(6)).to eq(0)
  end

  it "should give the row position" do
    expect(@board_game.get_row(0)).to eq(0)
    expect(@board_game.get_row(3)).to eq(1)
    expect(@board_game.get_row(8)).to eq(2)
  end

  it "should set the mark at the position 8" do
    board_expected = [[0, 1, "X"], [3, 4, 5], [6, 7, 8]]
    @board_game.set_mark("X", 2)
    expect(@board_game.board).to eq(board_expected)
  end

  it "should set the mark at the position 4" do
    board_expected = [[0, 1, 2], [3, "X", 5], [6, 7, 8]]
    @board_game.set_mark("X", 4)
    expect(@board_game.board).to eq(board_expected)
  end

  it "should set the mark at the position 0" do
    board_expected = [["X", 1, 2], [3, 4, 5], [6, 7, 8]]
    @board_game.set_mark("X", 0)
    expect(@board_game.board).to eq(board_expected)
  end
end
