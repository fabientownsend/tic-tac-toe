require 'spec_helper'

require 'board'
require 'cli_interface'
require 'game_play'
require 'human'
require 'computer'

RSpec.describe GamePlay do
  let(:board) { Board.new }
  let(:output) { StringIO.new }

  it "should finish the game displaying a tie" do
    type_game = "1\n"
    first_player = "1\n"
    moves = "0\n1\n2\n4\n3\n6\n5\n8\n7\n"
    game_play = create_game_play("#{type_game}#{first_player}#{moves}")

    expect do
      game_play.game_selection
      game_play.select_first_player
      game_play.play
    end.to change { output.string }.to include("It's a tie!\n")
  end

  it "should finish the game with X as a winner" do
    type_game = "1\n"
    first_player = "1\n"
    moves = "0\n1\n3\n2\n6\n"
    game_play = create_game_play("#{type_game}#{first_player}#{moves}")

    expect do
      game_play.game_selection
      game_play.select_first_player
      game_play.play
    end.to change { output.string }.to include("The winner is: X")
  end

  it "should finish the game with O as a winner" do
    type_game = "1\n"
    first_player = "2\n"
    moves = "0\n1\n3\n2\n6\n"
    game_play = create_game_play("#{type_game}#{first_player}#{moves}")

    expect do
      game_play.game_selection
      game_play.select_first_player
      game_play.play
    end.to change { output.string }.to include("The winner is: O")
  end

  it "should be win by the player two with the second move already played" do
    type_game = "1\n"
    first_player = "2\n"
    moves_part_one = "0\n"
    already_played = "0\n"
    moves_part_two = "1\n3\n2\n6\n"
    game_play = create_game_play("#{type_game}#{first_player}#{moves_part_one}#{already_played}#{moves_part_two}")

    expect do
      game_play.game_selection
      game_play.select_first_player
      game_play.play
    end.to change { output.string }.to include("The winner is: O")
  end

  it "should be win by the player two with the second move too hight" do
    type_game = "1\n"
    first_player = "2\n"
    moves_part_one = "0\n"
    too_hight = "100\n"
    moves_part_two = "1\n3\n2\n6\n"
    game_play = create_game_play("#{type_game}#{first_player}#{moves_part_one}#{too_hight}#{moves_part_two}")

    expect do
      game_play.game_selection
      game_play.select_first_player
      game_play.play
    end.to change { output.string }.to include("The winner is: O")
  end


  it "should be win by the player two (round) with the second move too low" do
    type_game = "1\n"
    first_player = "2\n"
    moves_part_one = "0\n"
    too_low = "-100\n"
    moves_part_two = "1\n3\n2\n6\n"
    game_play = create_game_play("#{type_game}#{first_player}#{moves_part_one}#{too_low}#{moves_part_two}")

    expect do
      game_play.game_selection
      game_play.select_first_player
      game_play.play
    end.to change { output.string }.to include("The winner is: O")
  end

  it "should be win by the player two (round) with the second move invalid" do
    type_game = "1\n"
    first_player = "2\n"
    moves_part_one = "0\n"
    invalid_move = "fdhasjfjd\n"
    moves_part_two = "1\n3\n2\n6\n"
    game_play = create_game_play("#{type_game}#{first_player}#{moves_part_one}#{invalid_move}#{moves_part_two}")

    expect do
      game_play.game_selection
      game_play.select_first_player
      game_play.play
    end.to change { output.string }.to include("The winner is: O")
  end

  it "should be a tie when computer vs computer" do
    type_game = "3\n"
    first_player = "1\n"
    game_play = create_game_play("#{type_game}#{first_player}")

    expect do
      game_play.game_selection
      game_play.select_first_player
      game_play.play
    end.to change { output.string }.to include("It's a tie!\n")
  end

  it "should display the next menu in another language" do
    lang = "2\n"
    type_game = "3\n"
    game_play = create_game_play("#{lang}#{type_game}")

    expect do
      game_play.language
      game_play.game_selection
    end.to change { output.string }.to include("Ordinateur vs. Ordinateur")
  end

  def create_game_play(input)
    input = StringIO.new(input)
    interface = CliInterface.new(input, output, "spec/lang/")
    return GamePlay.new(Board.new, interface)
  end
end
