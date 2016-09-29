require 'spec_helper'
require 'board'
require 'move_evaluator'

RSpec.describe MoveEvaluator do
  let (:board) { Board.new }
  let (:move_evaluator) { MoveEvaluator.new }

  it "should return -1 when the evaluated player can be beat" do
    [0, 2, 4].each { |position| board.set_mark(Mark::CROSS, position) }
    [1, 3, 5].each { |position| board.set_mark(Mark::ROUND, position) }
    evaluated_player = Mark::ROUND

    expect(move_evaluator.evaluate_move(evaluated_player, board)).to eq(-1)
  end

  it "should return 0 when any player can win" do
    [0, 1, 5].each { |position| board.set_mark(Mark::CROSS, position) }
    [2, 3, 4].each { |position| board.set_mark(Mark::ROUND, position) }
    evaluated_player = Mark::ROUND

    expect(move_evaluator.evaluate_move(evaluated_player, board)).to eq(0)
  end

  it "should return 1 when the other player can't beat evaluated player" do
    [1, 3, 5].each { |position| board.set_mark(Mark::CROSS, position) }
    [0, 2, 4].each { |position| board.set_mark(Mark::ROUND, position) }
    evaluated_player = Mark::ROUND

    expect(move_evaluator.evaluate_move(evaluated_player, board)).to eq(1)
  end

  it "should evaluate the move for the player cross" do
    [1, 3, 5].each { |position| board.set_mark(Mark::CROSS, position) }
    [0, 2, 4].each { |position| board.set_mark(Mark::ROUND, position) }

    expect(move_evaluator.evaluate_move(nil, board)).to eq(-1)
  end
end
