require_relative 'player'
require_relative 'marks'

class Human < Player
  def initialize(mark, ui)
    super(mark)
    @ui = ui
  end

  def next_move
    @ui.get_int
  end
end
