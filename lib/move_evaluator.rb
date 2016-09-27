class MoveEvaluator
  def evaluate_move(evaluated_mark, board)
    @mark = evaluated_mark
    @board = board
    alphabeta(evaluated_mark, -1000, 1000)
  end

  private

  attr_accessor :board
  attr_accessor :mark

  def alphabeta(current_mark, alpha, beta)
    if board.win?(switch_mark(mark))
      return -1
    elsif board.win?(mark)
      return 1
    elsif board.tie?
      return 0
    else
      if current_mark ==mark
        miniming_player(switch_mark(current_mark), alpha, beta)
      else
        maximing_player(switch_mark(current_mark), alpha, beta)
      end
    end
  end

  def switch_mark(mark)
    if mark == Mark::ROUND
      Mark::CROSS
    else
      Mark::ROUND
    end
  end

  def maximing_player(current_mark, alpha, beta)
    maximum_value = -100

    board.free_positions.each do |position|
      new_value = get_value_move(current_mark, alpha, beta, position)

      maximum_value = max(maximum_value, new_value)
      alpha = max(alpha, maximum_value)

      if alpha >= beta
        break
      end
    end

    return maximum_value
  end

  def max(first, second)
    first < second ? second : first
  end

  def miniming_player(current_mark, alpha, beta)
    minimum_value = 100

    board.free_positions.each do |position|
      new_value = get_value_move(current_mark, alpha, beta, position)

      minimum_value = min(minimum_value, new_value)
      beta = min(beta, minimum_value)

      if alpha >= beta
        break
      end
    end

    return minimum_value
  end

  def min(first, second)
    first > second ? second : first
  end

  def get_value_move(current_mark, alpha, beta,  position)
    board.set_mark(current_mark, position)
    result = alphabeta(current_mark, alpha, beta)
    board.remove_mark(position, position)
    result
  end
end
