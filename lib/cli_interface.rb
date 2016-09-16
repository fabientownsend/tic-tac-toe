require 'yaml'

class CliInterface
  attr_accessor :input
  attr_accessor :output

  def initialize(input, output)
    @input = input
    @output = output
    @file = YAML::load(File.open('en_text.yml'))
  end

  def display_board(board)
    board.each { |line| display_line(line) }
  end

  def next_move(mark)
    output.print("#{mark} #{@file['next_move']} ")
    input.gets
  end

  def type_game
    output.puts("#{@file['which_game']}")
    input.gets
  end

  def occupied_position
    output.puts("#{@file['not_free']}")
  end

  def position_range
    output.puts("#{@file['limit_board']}")
  end

  def winner(mark)
    output.print("#{@file['winner']}: #{mark}!\n")
  end

  def tie
    output.puts("#{@file['tie']}")
  end

  def computer_move
    output.puts("#{@file['computer_move']}")
  end

  def menu_game
    output.print("#{@file['menu_type_games']}")
  end

  def menu_first_player
    output.print("#{@file['menu_first_player']}")
  end

  def get_value
    input.gets
  end

  def must_be_integer
    output.print("#{@file['integer']}")
  end

  private

  def display_line(row)
    row.each_with_index do |e, index|
      if index == row.size - 1
        output.print(" #{e} \n")
      else
        output.print(" #{e} |")
      end
    end
  end
end
