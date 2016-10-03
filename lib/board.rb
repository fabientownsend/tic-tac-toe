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

  def new_board(ui_board)
    ui_board.each_line.with_index do |line, line_index|
      line.strip!.gsub!("|", "")
      line.each_char.with_index do |column, column_index|
        if column == "X"
          @counter += 1
          board[line_index][column_index] = Mark::CROSS
        elsif column == "O"
          @counter += 1
          board[line_index][column_index] = Mark::ROUND
        end
      end
    end
  end

  def set_mark(mark, position)
    board[get_row(position)][get_column(position)] = mark
    @counter += 1
  end

  def remove_mark(mark, position)
    board[get_row(position)][get_column(position)] = mark
    @counter -= 1
  end

  def win?(mark)
    win_with_columns?(mark) || win_with_rows?(mark) || win_with_diagonal?(mark)
  end

  def tie?
    @counter == @POSITION_MAX && !win?(Mark::CROSS) && !win?(Mark::ROUND)
  end

  def free_positions
    board.flatten.select { |cell| cell.is_a?(Integer) }
  end

  private

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
    check_forward_diagonal?(mark) || check_backward_diagonal?(mark)
  end

  def check_forward_diagonal?(mark)
    [0, 1, 2].all? { |index| board[index][index] == mark }
  end

  def check_backward_diagonal?(mark)
    [0, 1, 2].all? { |index| board[index][backward_index(index)] == mark }
  end

  def backward_index(index)
    board.size - index - 1
  end
end
