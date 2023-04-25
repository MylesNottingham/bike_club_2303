require "./lib/ride"
require "./lib/biker"
require "./lib/bike_club"

RSpec.describe BikeClub do
  before(:each) do
    @bike_club = BikeClub.new("Spandex Mafia")
    @biker_1 = Biker.new("Kenny", 30)
    @biker_2 = Biker.new("Athena", 15)
    @ride_1 = Ride.new({ name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills })
    @ride_2 = Ride.new({ name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel })

    @biker_1.learn_terrain!(:gravel)
    @biker_1.learn_terrain!(:hills)
    @biker_1.log_ride(@ride_1, 92.5)
    @biker_1.log_ride(@ride_1, 91.1)
    @biker_1.log_ride(@ride_2, 60.9)
    @biker_1.log_ride(@ride_2, 61.6)

    @biker_2.learn_terrain!(:gravel)
    @biker_2.learn_terrain!(:hills)
    @biker_2.log_ride(@ride_1, 97.0)
    @biker_2.log_ride(@ride_2, 67.0)
    @biker_2.log_ride(@ride_1, 95.0)
    @biker_2.log_ride(@ride_2, 65.0)
  end

  describe "#initialize" do
    it "can initialize a biker with attributes" do
      expect(@bike_club).to be_a(BikeClub)
      expect(@bike_club.name).to eq("Spandex Mafia")
      expect(@bike_club.bikers).to eq([])
    end
  end

  describe "#add_biker" do
    it "can add bikers to the club" do
      expect(@bike_club.bikers).to eq([])

      expect(@bike_club.add_biker(@biker_1)).to eq([@biker_1])

      expect(@bike_club.bikers).to eq([@biker_1])

      expect(@bike_club.add_biker(@biker_2)).to eq([@biker_1, @biker_2])

      expect(@bike_club.bikers).to eq([@biker_1, @biker_2])
    end
  end

  describe "#most_rides" do
    it "can return the biker with the most rides" do
      @bike_club.add_biker(@biker_1)
      @bike_club.add_biker(@biker_2)

      expect(@biker_1.rides).to eq({ @ride_1 => [92.5, 91.1], @ride_2 => [60.9, 61.6] })
      expect(@biker_2.rides).to eq({ @ride_2 => [67.0, 65.0] })

      expect(@bike_club.most_rides).to eq(@biker_1)

      @biker_2.log_ride(@ride_2, 63.0)
      @biker_2.log_ride(@ride_2, 62.0)
      @biker_2.log_ride(@ride_2, 75.0)

      expect(@biker_1.rides).to eq({ @ride_1 => [92.5, 91.1], @ride_2 => [60.9, 61.6] })
      expect(@biker_2.rides).to eq({ @ride_2 => [67.0, 65.0, 63.0, 62.0, 75.0] })

      expect(@bike_club.most_rides).to eq(@biker_2)
    end
  end
end
