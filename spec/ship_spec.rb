require './lib/ship'

RSpec.describe Ship do

 describe "iteration 1" do
   cruiser = Ship.new("Cruiser", 3)

   it "is a Ship" do
     expect(cruiser.class).to be(Ship)
   end

   it "has a name" do
     expect(cruiser.name).to eq("Cruiser")
   end

   it "has a length" do
     expect(cruiser.length).to be(3)
   end

   it "has health" do
     expect(cruiser.health).to be(3)
   end

   it "has sunk?" do
     expect(cruiser.sunk?).to be false
   end

   it "can be hit" do
     cruiser.hit
     expect(cruiser.sunk?).to be false
   end

   it "can lose health" do
     expect(cruiser.health).to be(2)
   end

   it "can be sunk" do
     # already hit once on line 29
     cruiser.hit
     expect(cruiser.health).to be(1)
     expect(cruiser.sunk?).to be false
     cruiser.hit
     expect(cruiser.health).to be(0)
     expect(cruiser.sunk?).to be true
   end

 end
end
