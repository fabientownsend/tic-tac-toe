class GamePlay
  attr_reader :current_player

  def initialize(player_one, player_two, board, ui)
    @current_player = player_one
    @player_one = player_one
    @player_two = player_two
    @board = board
    @ui = ui
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
