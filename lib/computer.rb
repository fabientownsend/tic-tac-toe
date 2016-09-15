require_relative 'player'

class Computer < Player
  attr_reader :board

  def initialize(mark, ui, board)
    super(mark, ui)
    @board = board
  end

  def next_move
    ui.computer_move
    free_positions.shuffle.first
  end

  private

  def free_positions
    board.board.flatten.select { |cell| cell.is_a?(Integer) }
  end
end
