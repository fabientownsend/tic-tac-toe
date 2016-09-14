require 'spec_helper'
require 'computer'

RSpec.describe Computer do
  it "should give a random number" do
    computer = Computer.new("X")
    
    move = computer.next_move

    expect(move).to be >= 0
    expect(move).to be <= 8
  end
end
