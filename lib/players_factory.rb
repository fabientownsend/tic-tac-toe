require 'human'
require 'computer'

module Mark
  ROUND = "O"
  CROSS = "X"
end

class PlayersFactory
  def initialize(ui, board)
    @ui = ui
    @board = board
  end

  def create_human_vs_human
    players = []
    players << create_human(Mark::CROSS)
    players << create_human(Mark::ROUND)
    players
  end

  def create_computer_vs_computer
    players = []
    players << create_computer(Mark::CROSS)
    players << create_computer(Mark::ROUND)
    players
  end

  def create_human_vs_computer
    players = []
    players << create_human(Mark::CROSS)
    players << create_computer(Mark::ROUND)
    players
  end

  private

  def create_computer(mark)
    Computer.new(mark, @ui, @board)
  end

  def create_human(mark)
    Human.new(mark, @ui)
  end
end
