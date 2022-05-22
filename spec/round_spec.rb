require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/round'

RSpec.describe Round do

  # it "can welcome" do
  #   expect(Round.new.welcome).to be_nil
  # end
  #
  # it "can show boards" do
  #   expect(Round.new.shows_boards).to be_nil
  # end

  it "can reset round" do
    expect(Round.new.reset).to eq(2)
  end

end

# Almost all of the methods in this class interact
# with the CLI using gets/puts. Round class was
# primarily tested on the terminal.
