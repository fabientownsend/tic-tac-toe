class CliInterface
  def initialize(input, output)
    @input = input
    @output = output
  end

  def display_board(board)
    board.each do |e|
      if e % 3 == 0
        @output.print(" #{e} \n")
      else
        @output.print(" #{e} |")
      end
    end
  end
end
