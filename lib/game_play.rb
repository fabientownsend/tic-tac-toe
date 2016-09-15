require_relative 'human'
require_relative 'computer'

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
    selection = get_user_selection

    if selection.between?(1, 3)
      creation_type_game(selection)
    else
      game_selection
    end
  end

  def select_first_player
    @ui.menu_first_player
    selection = get_user_selection

    if selection.between?(1, 2)
      create_players(selection)
    else
      select_first_player
    end
  end

  def play
    until game_over
      set_net_player
      display_board
      play_move
    end

    display_board
    display_result
  end

  private

  attr_reader :board
  attr_reader :ui

  def create_players(selection)
    if selection == 1
      @current_player = @player_two
      @players = [@player_two, @player_one]
    else
      @current_player = @player_one
      @players = [@player_one, @player_two]
    end
  end

  def get_user_selection
    begin
      Integer(@ui.get_value)
    rescue
      @ui.must_be_integer
      get_user_selection
    end
  end

  def creation_type_game(type_game)
    if type_game == 1
      @player_one = Human.new("X", ui)
      @player_two = Human.new("O", ui)
    elsif type_game == 2
      @player_one = Human.new("X", ui)
      @player_two = Computer.new("O", ui, board)
    elsif type_game == 3
      @player_one = Computer.new("X", ui, board)
      @player_two = Computer.new("O", ui, board)
    end
  end

  def display_result
    if board.win?(@current_player.mark)
      ui.winner(@current_player.mark)
    elsif board.tie?
      ui.tie
    end
  end

  def set_net_player
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
    rescue OccupiedSpotError
      ui.occupied_position
      play_move
    rescue OutOfRangeError
      ui.position_range
      play_move
    rescue ArgumentError
      ui.position_range
      play_move
    end
  end
end
