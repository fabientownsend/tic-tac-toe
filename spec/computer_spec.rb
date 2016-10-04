require 'spec_helper'
require 'computer'
require 'board'

RSpec.describe Computer do
  let (:input) { StringIO.new("1\n") }
  let (:output) { StringIO.new }
  let (:ui) { CliInterface.new(input, output, "spec/lang/") }
  let (:board) { Board.new }

  it "the computer will move to block its opponent" do
    board.new_board("|OOX|
                     |XXO|
                     |   |")

    computer = Computer.new(Mark::ROUND, ui, board)

    board.set_mark(computer.mark, computer.next_move)
    assert_equal_board("OOX,XXO,O  ", board.board)
  end

  it "the computer will move to win" do
    board.new_board("|XXO|
                     |OO |
                     |   |")

    computer = Computer.new(Mark::ROUND, ui, board)

    board.set_mark(computer.mark, computer.next_move)
    assert_equal_board("XXO,OOO,   ", board.board)
  end

  def assert_equal_board(expected, got)
    result = ""

    got.flatten.each.with_index do |value, index|
      if !value.is_a?(Integer)
        result << value
      else
        result << " "
      end

      index += 1
      if index % 3 == 0 && index != 0 && index != got.flatten.size
        result << ","
      end

    end

    expect(result).to eq(expected)
  end
end
