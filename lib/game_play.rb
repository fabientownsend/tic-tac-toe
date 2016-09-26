require_relative 'players_factory'

module GameType
  HUMAN_VS_HUMAN = 1
  HUMAN_VS_COMPUTER = 2
  COMPUTER_VS_COMPUTER = 3
end

class GamePlay
  attr_reader :current_player

  def initialize(board, ui)
    @board = board
    @ui = ui
  end

  def language
    @ui.menu_lang
    selection = get_user_selection_between(1, @ui.count_lang)
    @ui.set_lang(selection)
  end

  def game_selection
    @ui.menu_game
    selection = get_user_selection_between(1, 3)
    create_players_for_game(selection)
  end

  def select_first_player
    @ui.menu_first_player
    selection = get_user_selection_between(1, 2)
    set_next_player(selection)
  end

  def play
    until game_over
      get_next_player
      display_board
      play_move
    end

    display_board
    display_result
  end

  private

  attr_reader :board
  attr_reader :ui

  def set_next_player(selection)
    if selection == 1
      @current_player = @players[1]
      @players.reverse!
    else
      @current_player = @player_one
      @current_player = @players[0]
    end
  end

  def get_user_selection_between(min, max)
    value = @ui.get_int

    if !value.between?(min, max)
      @ui.should_be_between(min, max)
      value = get_user_selection_between(min, max)
    end

    value
  end

  def create_players_for_game(type_selected)
    players_factory = PlayersFactory.new(ui, board)

    if type_selected == GameType::HUMAN_VS_HUMAN
      @players = players_factory.create_human_vs_human
    elsif type_selected == GameType::HUMAN_VS_COMPUTER
      @players = players_factory.create_human_vs_computer
    elsif type_selected == GameType::COMPUTER_VS_COMPUTER
      @players = players_factory.create_computer_vs_computer
    end
  end

  def display_result
    if board.win?(@current_player.mark)
      ui.winner(@current_player.mark)
    elsif board.tie?
      ui.tie
    end
  end

  def get_next_player
    @current_player = @players.reverse!.first
  end

  def game_over
    board.win?(@current_player.mark) || board.tie?
  end

  def display_board
    @ui.display_board(board.board)
  end

  def play_move
    ui.display_next_player(@current_player.mark)
    position = @current_player.next_move

    if !in_range?(position)
      ui.should_be_between(board.POSITION_MIN, board.POSITION_MAX - 1)
      play_move
    elsif available?(position)
      ui.occupied_position
      play_move
    else
      board.set_mark(@current_player.mark, position)
    end
  end

  def in_range?(position)
    position >= board.POSITION_MIN && position < board.POSITION_MAX
  end

  def available?(position)
    !@board.free_positions.include?(position)
  end
end
