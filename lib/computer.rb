require_relative 'player'

class Computer < Player
  def next_move
    @ui.computer_move
    rand(8)
  end
end
