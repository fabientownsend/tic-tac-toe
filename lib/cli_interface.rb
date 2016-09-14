class CliInterface
  def initialize(input, output)
    @input = input
    @output = output
  end

  def display_board(board)
    board.each { |line| display_line(line) }
  end

  def next_move(mark)
    @output.print("#{mark} what is your next move? ")
    @input.gets
  end

  def occupied_position
    @output.print("This position isn't free\n")
  end

  def position_range
    @output.print("The value have to be an integer between 0 and 8\n")
  end

  def winner(mark)
    @output.print("The winner is: #{mark}!\n")
  end

  def tie
    @output.print("It's a tie!\n")
  end

  def computer_move
    @output.print("The computer will play its next move\n")
  end

  private

  def display_line(row)
    row.each_with_index do |e, index|
      if index == row.size - 1
        @output.print(" #{e} \n")
      else
        @output.print(" #{e} |")
      end
    end
  end
end
