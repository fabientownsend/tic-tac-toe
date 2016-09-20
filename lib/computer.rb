require_relative 'player'
require_relative 'board'
require_relative 'cli_interface'

class Computer < Player
  attr_reader :board

  def initialize(mark, ui, board)
    super(mark, ui)
    @board = board
    @ui = CliInterface.new(Kernel, Kernel)
  end

  def next_move
    ui.computer_move
    best_move
  end

  def best_move
    best_value = -100
    best_move = -1

    free_positions.each do |position|
      board.set_mark(mark, position)
      result = minimax(board, mark)
      board.remove_mark(position, position)

      if result > best_value
        best_value = result
        best_move = position
      end
    end

    best_move
  end

  def minimax(board, current_mark)
    if board.win?(switch_mark(mark))
      return -1
    elsif board.win?(mark)
      return 1
    elsif board.tie?
      return 0
    else
      if current_mark == mark
        best_value = 100

        free_positions.each do |position|
          board.set_mark(switch_mark(current_mark), position)

          result = minimax(board, switch_mark(current_mark))

          board.remove_mark(position, position)

          best_value = best_value > result ? result : best_value
        end

        return best_value
      else
        best_value = -100

        free_positions.each do |position|
          board.set_mark(switch_mark(current_mark), position)

          result = minimax(board, switch_mark(current_mark))

          board.remove_mark(position, position)

          best_value = best_value < result ? result : best_value
        end

        return best_value
      end
    end

  end

  def min(first, second)
    if first < second
      first
    else
      second
    end
  end

  def switch_mark(mark)
    if mark == Mark::ROUND
      Mark::CROSS
    else
      Mark::ROUND
    end
  end

  private

  def free_positions
    board.board.flatten.select { |cell| cell.is_a?(Integer) }
  end
end
