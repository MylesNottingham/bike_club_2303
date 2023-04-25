require "./lib/ride"
require "./lib/biker"

RSpec.describe Biker do
  before(:each) do
    @biker_1 = Biker.new("Kenny", 30)
    @biker_2 = Biker.new("Athena", 15)
    @ride_1 = Ride.new({ name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills })
    @ride_2 = Ride.new({ name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel })
  end

  describe "#initialize" do
    it "can initialize a biker with attributes" do
      expect(@biker_1).to be_a(Biker)
      expect(@biker_1.name).to eq("Kenny")
      expect(@biker_1.max_distance).to eq(30)
      expect(@biker_1.rides).to eq({})
      expect(@biker_1.acceptable_terrain).to eq([])
    end

    it "can initialize another biker with attributes" do
      expect(@biker_2).to be_a(Biker)
      expect(@biker_2.name).to eq("Athena")
      expect(@biker_2.max_distance).to eq(15)
      expect(@biker_2.rides).to eq({})
      expect(@biker_2.acceptable_terrain).to eq([])
    end
  end

  describe "#learn_terrain!(terrain)" do
    it "can add terrain to the acceptable_terrain array" do
      expect(@biker_1.acceptable_terrain).to eq([])

      @biker_1.learn_terrain!(:gravel)

      expect(@biker_1.acceptable_terrain).to eq([:gravel])

      @biker_1.learn_terrain!(:hills)

      expect(@biker_1.acceptable_terrain).to eq([:gravel, :hills])
    end
  end

  describe "#log_ride(ride, time)" do
    it "can add a ride and its times to the rides hash" do
      @biker_1.learn_terrain!(:gravel)
      @biker_1.learn_terrain!(:hills)

      expect(@biker_1.rides).to eq({})

      @biker_1.log_ride(@ride_1, 92.5)

      expect(@biker_1.rides).to eq({ @ride_1 => [92.5] })

      @biker_1.log_ride(@ride_1, 91.1)

      expect(@biker_1.rides).to eq({ @ride_1 => [92.5, 91.1] })
    end

    it "can add another ride and its times to the rides hash" do
      @biker_1.learn_terrain!(:gravel)
      @biker_1.learn_terrain!(:hills)

      expect(@biker_1.rides).to eq({})

      @biker_1.log_ride(@ride_1, 92.5)
      @biker_1.log_ride(@ride_1, 91.1)
      @biker_1.log_ride(@ride_2, 60.9)
      @biker_1.log_ride(@ride_2, 61.6)

      expect(@biker_1.rides).to eq({ @ride_1 => [92.5, 91.1], @ride_2 => [60.9, 61.6] })
    end

    it "will not add ride to rides if terrain is unnaceptable" do
      expect(@biker_2.rides).to eq({})

      @biker_2.log_ride(@ride_1, 97.0)
      @biker_2.log_ride(@ride_2, 67.0)

      expect(@biker_2.rides).to eq({})
    end

    it "will not add ride to rides if distance is too long" do
      @biker_2.learn_terrain!(:gravel)
      @biker_2.learn_terrain!(:hills)

      expect(@biker_2.rides).to eq({})

      @biker_2.log_ride(@ride_1, 95.0)
      @biker_2.log_ride(@ride_2, 65.0)

      expect(@biker_2.rides).to eq({ @ride_2 => [65.0] })
    end
  end

  describe "#personal_record(ride)" do
    it "will return the fastest time for a given ride" do
      @biker_1.learn_terrain!(:gravel)
      @biker_1.learn_terrain!(:hills)
      @biker_1.log_ride(@ride_1, 92.5)
      @biker_1.log_ride(@ride_1, 91.1)
      @biker_1.log_ride(@ride_2, 60.9)
      @biker_1.log_ride(@ride_2, 61.6)

      expect(@biker_1.personal_record(@ride_1)).to eq(91.1)
      expect(@biker_1.personal_record(@ride_2)).to eq(60.9)
    end

    it "will return false if the biker has not ridden the given ride" do
      @biker_2.learn_terrain!(:gravel)
      @biker_2.learn_terrain!(:hills)
      @biker_2.log_ride(@ride_1, 95.0)
      @biker_2.log_ride(@ride_2, 65.0)

      expect(@biker_2.personal_record(@ride_2)).to eq(65.0)
      expect(@biker_2.personal_record(@ride_1)).to eq(false)
    end
  end
end
