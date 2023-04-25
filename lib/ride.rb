class Ride
  attr_reader :name,
              :distance,
              :terrain

  def initialize(ride_info)
    @name = ride_info[:name]
    @distance = ride_info[:distance]
    @terrain = ride_info[:terrain]
    @is_loop = ride_info[:loop]
  end

  def loop?
    @is_loop
  end

  def total_distance
    loop? ? @distance : @distance * 2
  end
end
