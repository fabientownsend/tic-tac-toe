require 'game_play'
require 'player'

RSpec.describe GamePlay do
  before(:all) do
    @player_one = Player.new
    @player_one = Player.new
    @game_play = GamePlay.new(@player_one, @player_one, nil, nil)
  end

  it "should be player one the current first player" do
    expect(@game_play.current_player).to eq(@player_one)
  end

  it "should switch the current player" do
    @game_play.switch_player

    expect(@game_play.current_player).to eq(@player_one)
  end
  
  it "should be player when two switch" do
    @game_play.switch_player
    @game_play.switch_player

    expect(@game_play.current_player).to eq(@player_one)
  end
end
