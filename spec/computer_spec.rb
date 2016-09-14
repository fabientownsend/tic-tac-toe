require 'spec_helper'
require 'computer'

RSpec.describe Computer do
  it "should give a random number" do
    input = StringIO.new("1\n")
    output = StringIO.new
    ui = CliInterface.new(input, output)
    computer = Computer.new("X", ui)
    
    move = computer.next_move

    expect(move).to be >= 0
    expect(move).to be <= 8
  end
end
