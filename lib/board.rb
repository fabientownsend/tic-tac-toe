class BoardGame
  attr_reader :board

  def initialize
    @board = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
    @POSITION_MIN = 0
    @POSITION_MAX = @board.size ** 2
  end

  def is_valid?(position)
    position >= @POSITION_MIN && position < @POSITION_MAX
  end

  def is_free?(position)
    @board[get_row(position)][get_column(position)].is_a? Integer
  end

  def set_mark(mark, position)
    @board[get_row(position)][get_column(position)] = mark
  end

  def get_column(position)
    position % @board.size
  end

  def get_row(position)
    position / @board.size
  end
end
