class GamePlay
  attr_reader :current_player

  def initialize(player_one, player_two, board, ui)
    @current_player = player_one
    @player_one = player_one
    @player_two = player_two
    @players = [player_one, player_two]
    @board = board
    @ui = ui
  end

  def play
    until game_over
      switch_player
      display_board
      play_move
    end

    display_board
  end

  def game_over
    @board.win?(@current_player.mark)
  end

  def switch_player
    @current_player =
      if @current_player == @player_one
        @player_two
      else
        @player_one
      end
    #@players.flip!.first
  end

  def display_board
    @ui.display_board(@board.board)
  end

  def play_move
      position = @ui.next_move

      until @board.is_valid?(position) && @board.is_free?(position)
        position = @ui.next_move
      end

      @board.set_mark(@current_player.mark, position)
  end
end
