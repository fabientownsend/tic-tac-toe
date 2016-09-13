require 'game_play'
require 'player'

RSpec.describe GamePlay do
  let(:player_one) {Player.new("X")}
  let(:player_two) {Player.new("O")}
  let(:game_play) {GamePlay.new(player_one, player_two, nil, nil)}

  it "should be player one the current first player" do
    expect(game_play.current_player).to eq(player_one)
  end
end