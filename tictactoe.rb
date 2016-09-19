require_relative './lib/cli_interface'
require_relative './lib/human'
require_relative './lib/computer'
require_relative './lib/board'
require_relative './lib/game_play'

ui = CliInterface.new(Kernel, Kernel)
board = Board.new
game_play = GamePlay.new(board, ui)

game_play.game_selection
game_play.select_first_player
game_play.play
