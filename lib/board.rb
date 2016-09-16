class Board
  attr_reader :board
  attr_reader :POSITION_MIN
  attr_reader :POSITION_MAX

  def initialize
    @board = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
    @POSITION_MIN = 0
    @POSITION_MAX = board.size ** 2
    @counter = 0
  end

  def set_mark(mark, position)
    begin
      position = Integer(position)
      valid?(position)
      free?(position)
    rescue
      raise
    end

    board[get_row(position)][get_column(position)] = mark
    @counter += 1
  end

  def empty?
    @counter == 0
  end

  def win?(mark)
    win_with_columns?(mark) || win_with_rows?(mark) || win_with_diagonal?(mark)
  end

  def tie?
    @counter == @POSITION_MAX && !win?("X") && !win?("O")
  end

  private

  def free?(position)
    if not board[get_row(position)][get_column(position)].is_a? Integer
      raise OccupiedSpotError
    end
  end

  def valid?(position)
    if position < @POSITION_MIN || position >= @POSITION_MAX
      raise OutOfRangeError
    end
  end

  def get_column(position)
    position % board.size
  end

  def get_row(position)
    position / board.size
  end

  def win_with_columns?(mark)
    board.transpose.any? { |column| same_symbole?(column, mark) }
  end

  def win_with_rows?(mark)
    board.any? { |row| same_symbole?(row, mark) }
  end

  def same_symbole?(array, mark)
    array.all? { |row| row == mark }
  end

  def win_with_diagonal?(mark)
    check_diag_one(mark) || check_diag_two(mark)
  end

  def check_diag_one(mark)
    result = true

    board.each_with_index do |value, index|
      if board[index][index] != mark
        result = false
      end
    end

    result
  end

  def check_diag_two(mark)
    result = true

    board.each_with_index do |value, index|
      if board[index][board.size - index - 1] != mark
        result = false
      end
    end

    result
  end
end

class OutOfRangeError < Exception
end

class OccupiedSpotError < Exception
end
