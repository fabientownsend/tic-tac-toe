require 'spec_helper'
require 'game_play'
require 'player'

RSpec.describe GamePlay do
  let(:player_one) {Player.new("X", nil)}
  let(:player_two) {Player.new("O", nil)}

  let(:input) {StringIO.new("1\n")}
  let(:output) {StringIO.new}
  let(:interface) {CliInterface.new(input, output)}

  let(:board) {Board.new}

  let(:game_play) {GamePlay.new(player_one, player_two, board, interface)}

  it "should be player one the current first player" do
    expect(game_play.current_player).to eq(player_one)
  end

  it "should finish the game displaying a tie" do
    board.set_mark("X", 0)
    board.set_mark("O", 1)
    board.set_mark("X", 2)
    board.set_mark("X", 3)
    board.set_mark("O", 4)
    board.set_mark("X", 5)
    board.set_mark("O", 6)
    board.set_mark("X", 7)
    board.set_mark("O", 8)

    game_play.play
    expect(output.string).to include("It's a tie!\n")
  end

  it "should finish the game displaying a tie" do
    board.set_mark("X", 0)
    board.set_mark("X", 1)
    board.set_mark("X", 2)
    board.set_mark("X", 3)
    board.set_mark("O", 4)
    board.set_mark("X", 5)
    board.set_mark("O", 6)
    board.set_mark("X", 7)
    board.set_mark("O", 8)

    game_play.play
    expect(output.string).to include("The winner is: ")
  end
end
