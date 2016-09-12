class Board
  attr_reader :board

  def initialize
    @board = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
    @POSITION_MIN = 0
    @POSITION_MAX = @board.size ** 2
    @empty = true
  end

  def is_valid?(position)
    position >= @POSITION_MIN && position < @POSITION_MAX
  end

  def is_free?(position)
    @board[get_row(position)][get_column(position)].is_a? Integer
  end

  def set_mark(mark, position)
    @board[get_row(position)][get_column(position)] = mark
    @empty = false
  end

  def empty?
    @empty
  end

  def win?(mark)
    win_with_columns?(mark) || win_with_rows?(mark) || win_with_diagonal?(mark)
  end

  private

  def get_column(position)
    position % @board.size
  end

  def get_row(position)
    position / @board.size
  end

  def win_with_columns?(mark)
    @board.transpose.any? { |column| same_symbole?(column, mark) }
  end

  def win_with_rows?(mark)
    @board.any? { |row| same_symbole?(row, mark) }
  end

  def same_symbole?(array, mark)
    array.all? { |row| row == mark }
  end

  def win_with_diagonal?(mark)
    if @board[0][0] == mark && @board[1][1] == mark && @board[2][2] == mark
      true
    elsif @board[0][2] == mark && @board[1][1] == mark && @board[2][0] == mark
      true
    else
      false
    end
  end
end
