require 'spec_helper'
require 'cli_interface'
require 'board'

module Lang
  FRENCH = 2
end

RSpec.describe CliInterface do
  let(:input) {StringIO.new("1\n")}
  let(:output) {StringIO.new}
  let(:interface) {CliInterface.new(input, output, "spec/lang/")}

  it "should display the board" do
    board = Board.new
    board_result = " 0 | 1 | 2 \n 3 | 4 | 5 \n 6 | 7 | 8 \n"

    interface.display_board(board.board)

    expect(output.string).to eq(board_result)
  end

  it "should return a value" do
    expect(interface.read).to eq("1\n")
  end

  it "should print text" do
    interface.write("test")

    expect(output.string).to eq("test")
  end

  it "shoudl raise an exception when file doesn't exist" do
    expect {  CliInterface.new(input, output, "random/link") }.to raise_error(NoDefaultLangError)
  end

  it "should display a menu with the diferent lang find in the lang folder" do
    menu = "Select the language\n 1 - English\n 2 - Francais\n"

    interface.menu_lang

    expect(output.string).to eq(menu)
  end

  it "shoud be english language by default" do
    interface.occupied_position

    expect(output.string).to eq("This position isn't free\n")
  end

  it "shoud display in french when you select french" do
    expect do
      interface.set_lang(Lang::FRENCH)
      interface.occupied_position
    end.to change { output.string }.to eq("Cette position n'est pas libre\n")
  end

  it "should use the default language when a sentence is missed in the curent file" do
    expect do
      interface.set_lang(Lang::FRENCH)
      interface.must_be_integer
    end.to change { output.string }.to eq("The value must be an integer: ")
  end
end
