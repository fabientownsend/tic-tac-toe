require 'spec_helper'

require 'board'
require 'cli_interface'
require 'game_play'
require 'human'
require 'computer'

RSpec.describe GamePlay do
  let(:board) {Board.new}

  it "should finish the game displaying a tie" do
    type_game = "1\n"
    first_player = "1\n"
    moves = "0\n1\n2\n4\n3\n6\n5\n8\n7\n"
    input = StringIO.new("#{type_game}#{first_player}#{moves}")
    output = StringIO.new
    interface = CliInterface.new(input, output, "spec/lang/")

    game_play = GamePlay.new(Board.new, interface)

    game_play.game_selection
    game_play.select_first_player
    game_play.play
    expect(output.string).to include("It's a tie!\n")
  end

  it "should finish the game displaying a tie" do
    type_game = "1\n"
    first_player = "1\n"
    moves = "0\n1\n3\n2\n6\n"
    input = StringIO.new("#{type_game}#{first_player}#{moves}")
    output = StringIO.new
    interface = CliInterface.new(input, output, "spec/lang/")


    game_play = GamePlay.new(Board.new, interface)
    game_play.game_selection
    game_play.select_first_player
    game_play.play
    expect(output.string).to include("The winner is: X")
  end

  it "should be win by the player two" do
    type_game = "1\n"
    first_player = "2\n"
    moves = "0\n1\n3\n2\n6\n"
    input = StringIO.new("#{type_game}#{first_player}#{moves}")
    output = StringIO.new
    interface = CliInterface.new(input, output, "spec/lang/")

    game_play = GamePlay.new(Board.new, interface)

    game_play.game_selection
    game_play.select_first_player
    game_play.play
    expect(output.string).to include("The winner is: O")
  end

  it "should be win by the player two with the second move already played" do
    type_game = "1\n"
    first_player = "2\n"

    moves_part_one = "0\n"
    already_played = "0\n"
    moves_part_two = "1\n3\n2\n6\n"
    input = StringIO.new("#{type_game}#{first_player}#{moves_part_one}#{already_played}#{moves_part_two}")
    output = StringIO.new
    interface = CliInterface.new(input, output, "spec/lang/")

    game_play = GamePlay.new(Board.new, interface)

    game_play.game_selection
    game_play.select_first_player
    game_play.play
    expect(output.string).to include("The winner is: O")
  end

  it "should be win by the player two with the second move too hight" do
    type_game = "1\n"
    first_player = "2\n"

    moves_part_one = "0\n"
    too_hight = "100\n"
    moves_part_two = "1\n3\n2\n6\n"
    input = StringIO.new("#{type_game}#{first_player}#{moves_part_one}#{too_hight}#{moves_part_two}")
    output = StringIO.new
    interface = CliInterface.new(input, output, "spec/lang/")

    game_play = GamePlay.new(Board.new, interface)

    game_play.game_selection
    game_play.select_first_player
    game_play.play
    expect(output.string).to include("The winner is: O")
  end

  it "should be win by the player two with the second move too low" do
    type_game = "1\n"
    first_player = "2\n"

    moves_part_one = "0\n"
    too_low = "-100\n"
    moves_part_two = "1\n3\n2\n6\n"
    input = StringIO.new("#{type_game}#{first_player}#{moves_part_one}#{too_low}#{moves_part_two}")
    output = StringIO.new
    interface = CliInterface.new(input, output, "spec/lang/")

    game_play = GamePlay.new(Board.new, interface)

    game_play.game_selection
    game_play.select_first_player
    game_play.play
    expect(output.string).to include("The winner is: O")
  end

  it "should be win by the player two with the second invalid" do
    type_game = "1\n"
    first_player = "2\n"

    moves_part_one = "0\n"
    invalid = "fdhasjfjd\n"
    moves_part_two = "1\n3\n2\n6\n"
    input = StringIO.new("#{type_game}#{first_player}#{moves_part_one}#{invalid}#{moves_part_two}")
    output = StringIO.new
    interface = CliInterface.new(input, output, "spec/lang/")

    game_play = GamePlay.new(Board.new, interface)

    game_play.game_selection
    game_play.select_first_player
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

  it "should not accept the first input but the second" do
    game_play = create_type_game("thisIsNotAValidInput\n3\n")
    game_play.game_selection

    expect(game_play.player_one).to be_a(Computer)
    expect(game_play.player_two).to be_a(Computer)
  end

  it "should not accept the first input which is too low but the second" do
    game_play = create_type_game("-1\n3\n")
    game_play.game_selection

    expect(game_play.player_one).to be_a(Computer)
    expect(game_play.player_two).to be_a(Computer)
  end

  it "should not accept the first input which is too hight but the second" do
    game_play = create_type_game("4\n3\n")
    game_play.game_selection

    expect(game_play.player_one).to be_a(Computer)
    expect(game_play.player_two).to be_a(Computer)
  end

  def create_type_game(type)
    input = StringIO.new(type)
    output = StringIO.new
    interface = CliInterface.new(input, output, "spec/lang/")

    GamePlay.new(Board.new, interface)
  end

  it "should set player one as first player" do
    type_game = "1\n"
    first_player = "1\n"
    input = StringIO.new("#{type_game}#{first_player}")
    output = StringIO.new
    interface = CliInterface.new(input, output, "spec/lang/")

    game_play = GamePlay.new(Board.new, interface)

    game_play.game_selection
    game_play.select_first_player

    expect(game_play.current_player).to eq(game_play.player_two)
  end

  it "should set player two as first player" do
    type_game = "1\n"
    first_player = "2\n"
    input = StringIO.new("#{type_game}#{first_player}")
    output = StringIO.new
    interface = CliInterface.new(input, output, "spec/lang/")

    game_play = GamePlay.new(Board.new, interface)

    game_play.game_selection
    game_play.select_first_player

    expect(game_play.current_player).to eq(game_play.player_one)
  end

  it "should not accept the first input which is too low but the second" do
    type_game = "1\n"
    first_player = "-1\n1\n"
    input = StringIO.new("#{type_game}#{first_player}")
    output = StringIO.new
    interface = CliInterface.new(input, output, "spec/lang/")

    game_play = GamePlay.new(Board.new, interface)

    game_play.game_selection
    game_play.select_first_player

    expect(game_play.current_player).to eq(game_play.player_two)
  end

  it "should not accept the first input which is too hight but the second" do
    type_game = "1\n"
    first_player = "5\n1\n"
    input = StringIO.new("#{type_game}#{first_player}")
    output = StringIO.new
    interface = CliInterface.new(input, output, "spec/lang/")

    game_play = GamePlay.new(Board.new, interface)

    game_play.game_selection
    game_play.select_first_player

    expect(game_play.current_player).to eq(game_play.player_two)
  end

  it "should not accept the first input which is invalid but the second" do
    type_game = "1\n"
    first_player = "asdfjkl;df\n1\n"
    input = StringIO.new("#{type_game}#{first_player}")
    output = StringIO.new
    interface = CliInterface.new(input, output, "spec/lang/")

    game_play = GamePlay.new(Board.new, interface)

    game_play.game_selection
    game_play.select_first_player

    expect(game_play.current_player).to eq(game_play.player_two)
  end

  it "should display the menu in French" do
    lang = "2\n"
    type_game = "2\n"
    input = StringIO.new("#{lang}#{type_game}")
    output = StringIO.new
    interface = CliInterface.new(input, output, "spec/lang/")

    game_play = GamePlay.new(Board.new, interface)

    game_play.language
    game_play.game_selection

    expect(output.string).to include("Humain vs. Humain")
  end
end
