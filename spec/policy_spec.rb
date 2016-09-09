require 'policy'

RSpec.describe GamePlay do
  before(:all) do
    @policy = Policy.new
  end

  it "should display the row" do
    row = [0, 1, 2]

    expect(@policy.same_symbole?(row)).to eq(false)
  end

  it "should be a same_symbole for a row" do
    row = ["X", "X", "X"]

    expect(@policy.same_symbole?(row)).to eq(true)
  end

  it "should be a win_colum for a colum" do
    board =[["X", 1, 2], ["X", 4, 5], [1, 6, 7]]

    expect(@policy.win_columns?(board)).to eq(false)
  end

  it "should be a win_colum for a colum" do
    board =[["X", 1, 2], ["X", 4, 5], ["X", 6, 7]]

    expect(@policy.win_columns?(board)).to eq(true)
  end

  it "should be a win_colum for the second colum" do
    board =[[1, "X", 2], [4, "X", 5], [7, "X", 7]]

    expect(@policy.win_columns?(board)).to eq(true)
  end

  it "should be a win_colum_last for the last colum" do
    board = [[1, 2, "X"], [3, 4, "X"] ,[5, 6, "X"]]

    expect(@policy.win_columns?(board)).to eq(true)
  end

  it "should not win diag" do
    board = [[1, 2, "X"], [3, "X", 5] ,[5, 6, "X"]]

    expect(@policy.win_diagonal(board)).to eq(false)
  end

  it "should win diag" do
    board = [["X", 2, 3], [3, "X", 5] ,[5, 6, "X"]]

    expect(@policy.win_diagonal(board)).to eq(true)
  end

  it "should not win diag 2" do
    board = [[1, 2, "X"], [3, "X", 5] ,["X", 6, 8]]

    expect(@policy.win_diagonal(board)).to eq(true)
  end

  it "should verify each line win line 3" do
    board = [[1, 2, 3], [3, 4, 5] ,["X", "X", "X"]]

    expect(@policy.win_rows?(board)).to eq(true)
  end

  it "should verify each line win line 2" do
    board = [[1, 2, 3], ["X", "X", "X"], [3, 4, 5]]

    expect(@policy.win_rows?(board)).to eq(true)
  end

  it "should verify each line win line 1" do
    board = [["X", "X", "X"], [1, 2, 3],  [3, 4, 5]]

    expect(@policy.win_rows?(board)).to eq(true)
  end
end
