require_relative 'player'

class Human < Player
  def next_move
    @ui.next_move(mark)
  end
end
