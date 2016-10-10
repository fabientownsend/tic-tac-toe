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
    file = Dir.glob("#{@source}*#{@FILE_EXTENTION}")[input - 1].to_s
    @text_file = YAML::load(File.open(file))
  end

  def menu_game(default = 1)
    display_menu(get_from_file('menu_type_games'), default)
  end

  def menu_lang(default = 1)
    languages = get_list_languages
    display_menu(languages, default)
  end

  def menu_first_player(default = 1)
    display_menu(get_from_file('menu_first_player'), default)
  end

  def display_board(board)
    board.each_with_index do |line, index|
      display_line(line)
      if board.size - 1 != index
        display_interline(line)
      end
    end
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

  def get_value
    read
  end

  def board_size(default = 1)
    display_menu(get_from_file('board_size'), default)
  end

  private

  attr_reader :text_file

  def display_menu(menu, default)
    menu.each_line.with_index do |line, index|
      if index == 0
        write(line)
      elsif index == default
        write("[X] - #{index} " + line)
      else
        write("[ ] - #{index} " + line)
      end
    end
  end

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
    content = " "

    row.each_with_index do |e, index|
      if index == row.size - 1
        write("#{e}".center(margin(row), content)  + "\n")
      else
        write("#{e}".center(margin(row), content)  + "|")
      end
    end
  end

  def display_interline(row)
    write( "-" * (row.size + margin(row) * row.size - 1) + "\n")
  end

  def margin(row)
      (row.size ** 2).to_s.size + 2
  end

  def get_list_languages
    languages = "#{get_from_file('menu_lang')}\n"

    Dir.entries(@source).each do |item, i|
      if item.end_with?("#{@FILE_EXTENTION}")
        @count_lang += 1
        languages << "#{item.chomp("#{@FILE_EXTENTION}").capitalize}\n"
      end
    end

    languages
  end
end

class NoDefaultLangError < Exception
end
