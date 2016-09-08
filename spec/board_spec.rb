require 'board'

RSpec.describe BoardGame do
  it "should have an empty board" do
  board_expected = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  board_game = BoardGame.new
  expect(board_game.board).to eq(board_expected)
  end
end
