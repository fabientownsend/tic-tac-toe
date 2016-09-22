require 'yaml'

class CliInterface
  attr_accessor :input
  attr_accessor :output

  def initialize(input, output, source)
    @input = input
    @output = output
    @source = source

    begin
      @default_file = YAML::load(File.open("#{source}english.yml"))
    rescue
      raise NoDefaultLangError
    end

    @text_file = @default_file
  end

  def set_lang(input)
    file = Dir.glob("#{@source}*")[input - 1].to_s
    @text_file = YAML::load(File.open(file))
  end

  def menu_game
    write("#{get_from_file('menu_type_games')}")
  end

  def menu_lang
    write("#{get_from_file('menu_lang')}\n")

    Dir.entries(@source).each_with_index do |item, i|
      next if item == "." || item == ".."
      write(" #{i - 1} - #{item.chomp(".yml").capitalize}\n")
    end
  end

  def menu_first_player
    write("#{get_from_file('menu_first_player')}")
  end

  def display_board(board)
    board.each { |line| display_line(line) }
  end

  def next_move(mark)
    write("#{mark} #{get_from_file('next_move')} ")
    read
  end

  def type_game
    write("#{get_from_file('which_game')}\n")
    read
  end

  def occupied_position
    write("#{get_from_file('not_free')}\n")
  end

  def winner(mark)
    write("#{get_from_file('winner')}: #{mark}!\n")
  end

  def tie
    write("#{get_from_file('tie')}\n")
  end

  def computer_move
    write("#{get_from_file('computer_move')}\n")
  end

  def must_be_integer
    write("#{get_from_file('integer')}: ")
  end

  def between(min, max)
    write("#{get_from_file('between')} #{min} #{get_from_file('and')} #{max}\n")
  end

  def read
    input.gets
  end

  def write(text)
    output.print(text)
  end

  private

  attr_reader :text_file

  def get_from_file(text)
    result = text_file[text]

    if result == nil
      result = @default_file[text]
      if result == nil
        raise InexistentText
      end
    end

    result
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

class NoDefaultLangError < Exception
end
