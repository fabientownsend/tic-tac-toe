class CliInterface
  def initialize(input, output)
    @input = input
    @output = output
  end

  def display_board(board)
    board.each { |line| display_line(line) }
  end

  def display_line(row)
    row.each_with_index do |e, index|
      if index == row.size - 1
        @output.print(" #{e} \n")
      else
        @output.print(" #{e} |")
      end
    end
  end

  def next_move
    @output.print("What is your next move? ")
    @input.gets.to_i
  end
end
