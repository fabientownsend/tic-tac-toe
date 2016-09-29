require_relative 'player'
require_relative 'board'
require_relative 'cli_interface'
require_relative 'marks'
require_relative 'move_evaluator'

class Computer < Player
  attr_reader :board

  def initialize(mark, board)
    super(mark)
    @board = board
    @move_evaluator = MoveEvaluator.new
  end

  def next_move
    best_value = -100
    best_move = -1

    board.free_positions.each do |position|
      board.set_mark(mark, position)
      result = @move_evaluator.evaluate_move(mark, board)
      board.remove_mark(position, position)

      if result > best_value
        best_value = result
        best_move = position
      end
    end

    best_move
  end
end
