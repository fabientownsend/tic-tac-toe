require_relative 'player'
require_relative 'marks'

class Human < Player
  def next_move
    ui.next_move(mark)
    ui.get_int
  end
end
