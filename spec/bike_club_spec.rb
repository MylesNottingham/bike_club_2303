require "./lib/ride"
require "./lib/biker"
require "./lib/bike_club"

RSpec.describe BikeClub do
  before(:each) do
    @bike_club = BikeClub.new("Spandex Mafia")
  end

  describe "#initialize" do
    it "can initialize a biker with attributes" do
      expect(@bike_club).to be_a(BikeClub)
      expect(@bike_club.name).to eq("Spandex Mafia")
      expect(@bike_club.bikers).to eq([])
    end
  end
end
