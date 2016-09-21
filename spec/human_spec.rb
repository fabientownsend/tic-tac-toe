require 'spec_helper'
require 'human'
require 'cli_interface'

RSpec.describe Human do
  it "should give the human number" do
    input = StringIO.new("1\n")
    output = StringIO.new
    ui = CliInterface.new(input, output, "spec/lang/")
    human = Human.new(Mark::CROSS, ui)

    expect(human.next_move).to eq("1\n")
  end
end
