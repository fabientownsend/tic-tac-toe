require 'marks'

class Board
  attr_reader :board
  attr_reader :POSITION_MIN
  attr_reader :POSITION_MAX

  def initialize(board_size = 3)
    @board = create_board(board_size)
    @POSITION_MIN = 0
    @POSITION_MAX = board.size ** 2
    @counter = 0
  end

  def set_mark(mark, position)
    board[get_row(position)][get_column(position)] = mark
    @counter += 1
  end

  def remove_mark(position)
    board[get_row(position)][get_column(position)] = Mark::EMPTY
    @counter -= 1
  end

  def win?(mark)
    win_with_columns?(mark) || win_with_rows?(mark) || win_with_diagonal?(mark)
  end

  def tie?
    @counter == @POSITION_MAX && !win?(Mark::CROSS) && !win?(Mark::ROUND)
  end

  def free_positions
    flat_board = board.flatten
    flat_board.each_index.select { |index| empty?(flat_board[index]) }
  end

  def string_to_board(board_string)
    rows = board_string.split(",")

    board.size.times do |index_row|
      board.size.times do |index_column|
        if rows[index_row].chars[index_column] == Mark::CROSS
          @counter += 1
          board[index_row][index_column] = Mark::CROSS
        elsif rows[index_row].chars[index_column] == Mark::ROUND
          @counter += 1
          board[index_row][index_column] = Mark::ROUND
        end
      end
    end
  end

  def to_s
    board_string = ""

    board.flatten.each.with_index do |value, index|
      if value == Mark::CROSS || value == Mark::ROUND
        board_string << value
      else
        board_string << " "
      end

      index += 1
      if  board_edge?(index) && index != @POSITION_MAX
        board_string << ","
      end

    end

    board_string
  end

  private

  def empty?(spot)
    spot != Mark::ROUND && spot != Mark::CROSS
  end

  def create_board(board_size)
    new_board = Array.new
    board_size.times do
      new_row = Array.new
      board_size.times do
        new_row.push(Mark::EMPTY)
      end
      new_board.push(new_row)
    end
    new_board
  end

  def board_edge?(index)
    index % board.size == 0
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

  def same_symbole?(rows, mark)
    rows.all? { |row| row == mark }
  end

  def win_with_diagonal?(mark)
    check_forward_diagonal?(mark) || check_backward_diagonal?(mark)
  end

  def check_forward_diagonal?(mark)
    board.size.times.all? { |index| board[index][index] == mark }
  end

  def check_backward_diagonal?(mark)
    board.size.times.all? { |index| board[index][backward_index(index)] == mark }
  end

  def backward_index(index)
    board.size - index - 1
  end
end
