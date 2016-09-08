class CliInterface
  def initialize(input, output)
    @input = input
    @output = output
  end

  def display_board(board)
    puts(board)
  end
end
