class Player
  attr_reader :mark
  attr_reader :ui

  def initialize(mark, ui)
    @mark = mark
    @ui = ui
  end
end
