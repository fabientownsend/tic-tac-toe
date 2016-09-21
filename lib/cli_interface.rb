require 'yaml'

class CliInterface
  attr_accessor :input
  attr_accessor :output
  attr_reader :source

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
    write("#{get_text('menu_type_games')}")
  end

  def menu_lang
    write("#{get_text('menu_lang')}\n")

    Dir.entries("lang").each_with_index do |item, i|
      next if item == "." || item == ".."
      write(" #{i - 1} - #{item.chomp(".yml").capitalize}\n")
    end
  end

  def menu_first_player
    write("#{get_text('menu_first_player')}")
  end

  def display_board(board)
    board.each { |line| display_line(line) }
  end

  def next_move(mark)
    write("#{mark} #{get_text('next_move')} ")
    read
  end

  def type_game
    write("#{get_text('which_game')}\n")
    read
  end

  def occupied_position
    write("#{get_text('not_free')}\n")
  end

  def winner(mark)
    write("#{get_text('winner')}: #{mark}!\n")
  end

  def tie
    write("#{get_text('tie')}\n")
  end

  def computer_move
    write("#{get_text('computer_move')}\n")
  end

  def must_be_integer
    write("#{get_text('integer')}: ")
  end

  def between(min, max)
    write("#{get_text('between')} #{min} #{get_text('and')} #{max}\n")
  end

  def read
    input.gets
  end

  def write(text)
    output.print(text)
  end

  private

  attr_reader :text_file

  def get_text(text)
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
