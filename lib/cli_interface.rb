require 'yaml'

class CliInterface
  attr_accessor :input
  attr_accessor :output

  def initialize(input, output)
    @input = input
    @output = output
    @text_file = YAML::load(File.open('en_text.yml'))
  end

  def display_board(board)
    board.each { |line| display_line(line) }
  end

  def next_move(mark)
    write("#{mark} #{text_file['next_move']} ")
    read
  end

  def type_game
    write("#{text_file['which_game']}\n")
    read
  end

  def occupied_position
    write("#{text_file['not_free']}\n")
  end

  def winner(mark)
    write("#{text_file['winner']}: #{mark}!\n")
  end

  def tie
    write("#{text_file['tie']}\n")
  end

  def computer_move
    write("#{text_file['computer_move']}\n")
  end

  def menu_game
    write("#{text_file['menu_type_games']}")
  end

  def menu_first_player
    write("#{text_file['menu_first_player']}")
  end

  def must_be_integer
    write("#{text_file['integer']}: ")
  end

  def between(min, max)
    write("#{text_file['between']} #{min} #{@text_file['and']} #{max}\n")
  end

  def read
    input.gets
  end

  private

  attr_reader :text_file

  def write(text)
    output.print(text)
  end
  
  def display_line(row)
    row.each_with_index do |e, index|
      if index == row.size - 1
        write(" #{e} \n")
      else
        write(" #{e} |")
      end
    end
  end
end
