require_relative 'player'

class Human < Player
  def initialize(mark, ui)
    super(mark)
    @ui = ui
  end

  def next_move
    @ui.next_move(mark)
  end
end
