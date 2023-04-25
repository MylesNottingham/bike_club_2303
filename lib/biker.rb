class Biker
  attr_reader :name,
              :max_distance,
              :rides,
              :acceptable_terrain

  def initialize(name, max_distance)
    @name = name
    @max_distance = max_distance
    @rides = Hash.new([])
    @acceptable_terrain = []
  end

  def learn_terrain!(terrain)
    @acceptable_terrain << terrain
  end

  def log_ride(ride, time)
    return unless ride.total_distance <= @max_distance && @acceptable_terrain.include?(ride.terrain)

    @rides[ride] += [time]
  end

  def personal_record(ride)
    return false if @rides[ride].empty?

    @rides[ride].min
  end
end
