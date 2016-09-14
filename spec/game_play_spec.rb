require 'spec_helper'

require 'board'
require 'cli_interface'
require 'game_play'
require 'human'

RSpec.describe GamePlay do
  let(:board) {Board.new}

  it "should finish the game displaying a tie" do
    input = StringIO.new("0\n1\n2\n4\n3\n6\n5\n8\n7\n")
    output = StringIO.new
    interface = CliInterface.new(input, output)

    player_one = Human.new("X", interface)
    player_two = Human.new("O", interface)

    board = Board.new

    game_play = GamePlay.new(player_one, player_two, board, interface)

    game_play.play
    expect(output.string).to include("It's a tie!\n")
  end

  it "should finish the game displaying a tie" do
    input = StringIO.new("1\n4\n7\n0\n2\n8\n")
    output = StringIO.new
    interface = CliInterface.new(input, output)

    player_one = Human.new("X", interface)
    player_two = Human.new("O", interface)

    board = Board.new

    game_play = GamePlay.new(player_one, player_two, board, interface)
    game_play.play
    expect(output.string).to include("The winner is: X")
  end

  it "should be win by the player two" do
    input = StringIO.new("0\n1\n3\n2\n6\n")
    output = StringIO.new
    interface = CliInterface.new(input, output)

    player_one = Human.new("X", interface)
    player_two = Human.new("O", interface)

    game_play = GamePlay.new(player_one, player_two, board, interface)

    game_play.play
    expect(output.string).to include("The winner is: O")
  end
end
