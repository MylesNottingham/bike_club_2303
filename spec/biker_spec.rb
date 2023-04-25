require "./lib/ride"
require "./lib/biker"

RSpec.describe Biker do
  before(:each) do
    @biker = Biker.new("Kenny", 30)
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

  describe "learn_terrain!(terrain)" do
    it "can add terrain to the acceptable_terrain array" do
      expect(@biker.acceptable_terrain).to eq([])

      @biker.learn_terrain!(:gravel)

      expect(@biker.acceptable_terrain).to eq([:gravel])

      @biker.learn_terrain!(:hills)

      expect(@biker.acceptable_terrain).to eq([:gravel, :hills])
    end
  end
end