require 'spec_helper'

require 'board'
require 'cli_interface'
require 'game_play'
require 'human'
require 'computer'

RSpec.describe GamePlay do
  let(:board) {Board.new}

  it "should finish the game displaying a tie" do
    input = StringIO.new("1\n0\n1\n2\n4\n3\n6\n5\n8\n7\n")
    output = StringIO.new
    interface = CliInterface.new(input, output)

    game_play = GamePlay.new(Board.new, interface)

    game_play.game_selection
    game_play.play
    expect(output.string).to include("It's a tie!\n")
  end

  it "should finish the game displaying a tie" do
    input = StringIO.new("1\n1\n4\n7\n0\n2\n8\n")
    output = StringIO.new
    interface = CliInterface.new(input, output)


    game_play = GamePlay.new(Board.new, interface)
    game_play.game_selection
    game_play.play
    expect(output.string).to include("The winner is: X")
  end

  it "should be win by the player two" do
    input = StringIO.new("1\n0\n1\n3\n2\n6\n")
    output = StringIO.new
    interface = CliInterface.new(input, output)

    game_play = GamePlay.new(Board.new, interface)

    game_play.game_selection
    game_play.play
    expect(output.string).to include("The winner is: O")
  end

  it "should create two human player" do
    game_play = create_type_game("1\n")
    game_play.game_selection

    expect(game_play.player_one).to be_a(Human)
    expect(game_play.player_two).to be_a(Human)
  end

  it "should create one human and one computer" do
    game_play = create_type_game("2\n")
    game_play.game_selection

    expect(game_play.player_one).to be_a(Human)
    expect(game_play.player_two).to be_a(Computer)
  end

  it "should create one human and one computer" do
    game_play = create_type_game("3\n")
    game_play.game_selection

    expect(game_play.player_one).to be_a(Computer)
    expect(game_play.player_two).to be_a(Computer)
  end

  it "should create one human and one computer" do
    game_play = create_type_game("thisIsNotAValidInput\n3\n")
    game_play.game_selection

    expect(game_play.player_one).to be_a(Computer)
    expect(game_play.player_two).to be_a(Computer)
  end

  def create_type_game(type)
    input = StringIO.new(type)
    output = StringIO.new
    interface = CliInterface.new(input, output)

    GamePlay.new(Board.new, interface)
  end
end
