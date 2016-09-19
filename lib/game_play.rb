require_relative 'human'
require_relative 'computer'

module GameType
  HUMAN_VS_HUMAN = 1
  HUMAN_VS_COMPUTER = 2
  COMPUTER_VS_COMPUTER = 3
end

module Mark
  ROUND = "O"
  CROSS = "X"
end

class GamePlay
  attr_reader :player_one
  attr_reader :player_two
  attr_reader :current_player

  def initialize(board, ui)
    @board = board
    @ui = ui
  end

  def game_selection
    @ui.menu_game
    selection = get_user_selection_between(1, 3)
    creation_type_game(selection)
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
      @current_player = @player_two
      @players = [@player_two, @player_one]
    else
      @current_player = @player_one
      @players = [@player_one, @player_two]
    end
  end

  def get_user_selection_between(min, max)
    value = get_user_selection

    if !value.between?(min, max)
      @ui.between(min, max)
      value = get_user_selection_between(min, max)
    end

    value
  end

  def get_user_selection
    begin
      selection = Integer(@ui.read)
    rescue
      @ui.must_be_integer
      selection = get_user_selection
    end

    selection
  end

  def creation_type_game(type_selected)
    if type_selected == GameType::HUMAN_VS_HUMAN
      @player_one = Human.new(Mark::CROSS, ui)
      @player_two = Human.new(Mark::ROUND, ui)
    elsif type_selected == GameType::HUMAN_VS_COMPUTER
      @player_one = Human.new(Mark::CROSS, ui)
      @player_two = Computer.new(Mark::ROUND, ui, board)
    elsif type_selected == GameType::COMPUTER_VS_COMPUTER
      @player_one = Computer.new(Mark::CROSS, ui, board)
      @player_two = Computer.new(Mark::ROUND, ui, board)
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
    position = @current_player.next_move

    begin
      board.set_mark(@current_player.mark, position)
    rescue OccupiedPositionError
      ui.occupied_position
      play_move
    rescue OutOfRangeError
      ui.between(board.POSITION_MIN, board.POSITION_MAX)
      play_move
    rescue ArgumentError
      ui.must_be_integer
      play_move
    end
  end
end
