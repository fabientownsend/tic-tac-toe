class GamePlay
  attr_reader :current_player

  def initialize(player_one, player_two, board)
    @current_player = player_one
    @player_one = player_one
    @player_two = player_two
    @board = board
  end

  def switch_player
    @current_player =
      if @current_player == @player_one
        @player_two
      else
        @player_one
      end
  end
end
