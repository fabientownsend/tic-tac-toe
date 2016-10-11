require 'yaml'

class CliInterface
  attr_accessor :input
  attr_accessor :output
  attr_reader :count_lang

  def initialize(input, output, source)
    @input = input
    @output = output
    @source = source
    @count_lang = 0
    @FILE_EXTENTION = ".yml"

    begin
      @default_file = YAML::load(File.open("#{source}english.yml"))
    rescue
      raise NoDefaultLangError
    end

    @text_file = @default_file
  end

  def set_lang(input)
    file = Dir.glob("#{@source}*#{@FILE_EXTENTION}").sort[input - 1].to_s
    @text_file = YAML::load(File.open(file))
  end

  def menu_game
    write("#{get_from_file('menu_type_games')}")
  end

  def menu_lang
    display_lang_files
  end

  def menu_first_player
    write("#{get_from_file('menu_first_player')}")
  end

  def display_board(board)
    board.each { |line| display_line(line) }
  end

  def display_next_player(mark)
    write("#{mark} #{get_from_file('next_move')}\n")
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

  def must_be_integer
    write("#{get_from_file('integer')}: ")
  end

  def should_be_between(min, max)
    write("#{get_from_file('between')} #{min} #{get_from_file('and')} #{max}\n")
  end

  def read
    input.gets
  end

  def write(text)
    output.print(text)
  end

  def get_int
    begin
      selection = Integer(read)
    rescue
      must_be_integer
      selection = get_int
    end

    selection
  end

  def board_size
    write("#{get_from_file('board_size')}: ")
  end

  private

  attr_reader :text_file

  def get_from_file(text)
    result = text_file[text]

    if result == nil
      result = @default_file[text]
      if result == nil
        result = "blank"
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

  def display_lang_files
    menu = "#{get_from_file('menu_lang')}\n"
    language = ""

    Dir.entries(@source).each do |item, i|
      if item.end_with?("#{@FILE_EXTENTION}")
        @count_lang += 1
        language << " #{@count_lang} - #{item.chomp("#{@FILE_EXTENTION}").capitalize}\n"
      end
    end

    menu << language.lines.sort.join
    write(menu)
  end
end

class NoDefaultLangError < Exception
end
