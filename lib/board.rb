class BoardGame
  attr_reader :board

  def initialize
    @board = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
  end

  def set_mark(mark, position)
    @board[get_row(position)][get_column(position)] = mark
  end

  def get_column position
    position % @board.size
  end

  def get_row position
    position / @board.size
  end
end
