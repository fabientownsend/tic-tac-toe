require_relative 'player'

class Computer < Player
  def initialize(mark, ui, board)
    super(mark, ui)
    @board = board
  end

  def next_move
    @ui.computer_move
    rand(8)
  end
end
