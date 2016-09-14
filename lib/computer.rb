require_relative 'player'

class Computer < Player
  def next_move
    rand(8)
  end
end
