require "./lib/ride"
require "./lib/biker"

RSpec.describe Biker do
  before(:each) do
    @biker = Biker.new("Kenny", 30)
    @ride_1 = Ride.new({ name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills })
    @ride_2 = Ride.new({ name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel })
  end

  describe "#initialize" do
    it "can initialize a biker with attributes" do
      expect(@biker).to be_a(Biker)
      expect(@biker.name).to eq("Kenny")
      expect(@biker.max_distance).to eq(30)
      expect(@biker.rides).to eq({})
      expect(@biker.acceptable_terrain).to eq([])
    end
  end

  describe "#learn_terrain!(terrain)" do
    it "can add terrain to the acceptable_terrain array" do
      expect(@biker.acceptable_terrain).to eq([])

      @biker.learn_terrain!(:gravel)

      expect(@biker.acceptable_terrain).to eq([:gravel])

      @biker.learn_terrain!(:hills)

      expect(@biker.acceptable_terrain).to eq([:gravel, :hills])
    end
  end

  describe "#log_ride(ride, time)" do
    it "can add a ride and its times to the rides hash" do
      expect(@biker.rides).to eq({})

      @biker.log_ride(@ride_1, 92.5)

      expect(@biker.rides).to eq({ @ride_1 => [92.5] })

      @biker.log_ride(@ride_1, 91.1)

      expect(@biker.rides).to eq({ @ride_1 => [92.5, 91.1] })
    end

    it "can add another ride and its times to the rides hash" do
      expect(@biker.rides).to eq({})

      @biker.log_ride(@ride_1, 92.5)
      @biker.log_ride(@ride_1, 91.1)
      @biker.log_ride(@ride_2, 60.9)
      @biker.log_ride(@ride_2, 61.6)

      expect(@biker.rides).to eq({ @ride_1 => [92.5, 91.1], @ride_2 => [60.9, 61.6] })
    end
  end
end