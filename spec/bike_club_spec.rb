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
      @biker_2.learn_terrain!(:gravel)
      @biker_2.learn_terrain!(:hills)
      @biker_2.log_ride(@ride_1, 97.0)
      @biker_2.log_ride(@ride_2, 67.0)
      @biker_2.log_ride(@ride_1, 95.0)
      @biker_2.log_ride(@ride_2, 65.0)
      @bike_club.add_biker(@biker_1)
      @bike_club.add_biker(@biker_2)

      expect(@biker_1.rides).to eq({ @ride_1 => [92.5, 91.1], @ride_2 => [60.9, 61.6] })
      expect(@biker_2.rides).to eq({ @ride_2 => [67.0, 65.0] })

      expect(@bike_club.most_rides).to eq(@biker_1)

      @biker_2.log_ride(@ride_2, 62.0)
      @biker_2.log_ride(@ride_2, 61.0)
      @biker_2.log_ride(@ride_2, 60.0)

      expect(@biker_1.rides).to eq({ @ride_1 => [92.5, 91.1], @ride_2 => [60.9, 61.6] })
      expect(@biker_2.rides).to eq({ @ride_2 => [67.0, 65.0, 62.0, 61.0, 60.0] })

      expect(@bike_club.most_rides).to eq(@biker_2)
    end
  end

  describe "best_time(ride)" do
    it "can return the biker with the best time for a given ride" do
      @biker_2.learn_terrain!(:gravel)
      @biker_2.learn_terrain!(:hills)
      @biker_2.log_ride(@ride_1, 97.0)
      @biker_2.log_ride(@ride_2, 67.0)
      @biker_2.log_ride(@ride_1, 95.0)
      @biker_2.log_ride(@ride_2, 65.0)
      @bike_club.add_biker(@biker_1)
      @bike_club.add_biker(@biker_2)

      expect(@biker_1.rides).to eq({ @ride_1 => [92.5, 91.1], @ride_2 => [60.9, 61.6] })
      expect(@biker_2.rides).to eq({ @ride_2 => [67.0, 65.0] })

      expect(@bike_club.best_time(@ride_1)).to eq(@biker_1)
      expect(@bike_club.best_time(@ride_2)).to eq(@biker_1)

      @biker_2.log_ride(@ride_2, 62.0)
      @biker_2.log_ride(@ride_2, 61.0)
      @biker_2.log_ride(@ride_2, 60.0)

      expect(@biker_1.rides).to eq({ @ride_1 => [92.5, 91.1], @ride_2 => [60.9, 61.6] })
      expect(@biker_2.rides).to eq({ @ride_2 => [67.0, 65.0, 62.0, 61.0, 60.0] })

      expect(@bike_club.best_time(@ride_1)).to eq(@biker_1)
      expect(@bike_club.best_time(@ride_2)).to eq(@biker_2)
    end
  end

  describe "bikers_eligible(ride)" do
    it "can return all bikers who are eligible for a given ride" do
      @bike_club.add_biker(@biker_1)
      @bike_club.add_biker(@biker_2)

      expect(@biker_1.max_distance).to eq(30)
      expect(@biker_1.acceptable_terrain).to eq([:gravel, :hills])
      expect(@biker_2.max_distance).to eq(15)
      expect(@biker_2.acceptable_terrain).to eq([])

      expect(@ride_1.total_distance).to eq(21.4)
      expect(@ride_1.terrain).to eq(:hills)
      expect(@ride_2.total_distance).to eq(14.9)
      expect(@ride_2.terrain).to eq(:gravel)

      expect(@bike_club.bikers_eligible(@ride_1)).to eq([@biker_1])
      expect(@bike_club.bikers_eligible(@ride_2)).to eq([@biker_1])

      @biker_2.learn_terrain!(:hills)

      expect(@bike_club.bikers_eligible(@ride_1)).to eq([@biker_1])
      expect(@bike_club.bikers_eligible(@ride_2)).to eq([@biker_1])

      @biker_2.learn_terrain!(:gravel)

      expect(@bike_club.bikers_eligible(@ride_1)).to eq([@biker_1])
      expect(@bike_club.bikers_eligible(@ride_2)).to eq([@biker_1, @biker_2])
    end
  end

  describe "#bikers_have_ridden(ride)" do
    it "can return all bikers who have ridden a given ride" do
      @biker_2.learn_terrain!(:gravel)
      @biker_2.learn_terrain!(:hills)
      @biker_2.log_ride(@ride_1, 97.0)
      @biker_2.log_ride(@ride_2, 67.0)
      @biker_2.log_ride(@ride_1, 95.0)
      @biker_2.log_ride(@ride_2, 65.0)
      @bike_club.add_biker(@biker_1)
      @bike_club.add_biker(@biker_2)

      expect(@biker_1.rides).to eq({ @ride_1 => [92.5, 91.1], @ride_2 => [60.9, 61.6] })
      expect(@biker_2.rides).to eq({ @ride_2 => [67.0, 65.0] })

      expect(@bike_club.bikers_have_ridden(@ride_1)).to eq([@biker_1])
      expect(@bike_club.bikers_have_ridden(@ride_2)).to eq([@biker_1, @biker_2])
    end
  end
end
