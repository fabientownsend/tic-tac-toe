class CliInterface
  def initialize(input, output)
    @input = input
    @output = output
  end

  def display_board(board)
    board.each do |line|
      display_line(line)
    end
  end

  def display_line(row)
    row.each do |e|
      if e % row.size == row.size - 1
        @output.print(" #{e} \n")
      else
        @output.print(" #{e} |")
      end
    end
  end

  def next_move
    @output.print("What is your next move?")
  end
end
