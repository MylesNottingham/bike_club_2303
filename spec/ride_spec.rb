require "./lib/ride"

RSpec.describe Ride do
  before(:each) do
    @ride_1 = Ride.new({ name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills })
    @ride_2 = Ride.new({ name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel })
  end

  describe "#initialize" do
    it "can initialize a ride with attributes" do
      expect(@ride_1).to be_a(Ride)
      expect(@ride_1.name).to eq("Walnut Creek Trail")
      expect(@ride_1.distance).to eq(10.7)
      expect(@ride_1.terrain).to eq(:hills)
    end

    it "can initialize another ride with attributes" do
      expect(@ride_2).to be_a(Ride)
      expect(@ride_2.name).to eq("Town Lake")
      expect(@ride_2.distance).to eq(14.9)
      expect(@ride_2.terrain).to eq(:gravel)
    end
  end

  describe "#loop?" do
    it "can determine if a ride is a loop" do
      expect(@ride_1.loop?).to eq(false)
    end

    it "can determine if another ride is a loop" do
      expect(@ride_2.loop?).to eq(true)
    end
  end

  describe "#total_distance" do
    it "can calculate total distance of non-loop ride" do
      expect(@ride_1.distance).to eq(10.7)
      expect(@ride_1.loop?).to eq(false)
      expect(@ride_1.total_distance).to eq(21.4)
    end

    it "can calculate total distance of loop ride" do
      expect(@ride_2.distance).to eq(14.9)
      expect(@ride_2.loop?).to eq(true)
      expect(@ride_2.total_distance).to eq(14.9)
    end
  end
end
