class GamePlay
  attr_reader :current_player

  def initialize(player_one, player_two, board, ui)
    @current_player = player_one
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
    display_result
  end

  private

  def display_result
    if @board.win?(@current_player.mark)
      @ui.winner(@current_player.mark)
    elsif @board.tie?
      @ui.tie
    end
  end

  def switch_player
    @current_player = @players.reverse!.first
  end

  def game_over
    @board.win?(@current_player.mark) || @board.tie?
  end

  def display_board
    @ui.display_board(@board.board)
  end

  def play_move
    position = @current_player.next_move

    begin
      @board.set_mark(@current_player.mark, position)
    rescue OccupiedSpotError
      @ui.occupied_position
      play_move
    rescue OutOfRangeError
      @ui.position_range
      play_move
    rescue ArgumentError
      @ui.position_range
      play_move
    end
  end
end
