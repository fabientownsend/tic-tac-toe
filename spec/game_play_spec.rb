require 'game_play'
require 'player'

RSpec.describe GamePlay do
  it "should be player one the current first player" do
    player_one = Player.new
    player_two = Player.new
    game_play = GamePlay.new(player_one, player_two)

    expect(game_play.current_player).to eq(player_one)
  end

  it "should switch the current player" do
    player_one = Player.new
    player_two = Player.new
    game_play = GamePlay.new(player_one, player_two)

    game_play.switch_player

    expect(game_play.current_player).to eq(player_two)
  end
  
  it "should be player when two switch" do
    player_one = Player.new
    player_two = Player.new
    game_play = GamePlay.new(player_one, player_two)

    game_play.switch_player
    game_play.switch_player

    expect(game_play.current_player).to eq(player_one)
  end
end
