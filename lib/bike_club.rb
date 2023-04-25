class BikeClub
  attr_reader :name,
              :bikers

  def initialize(name)
    @name = name
    @bikers = []
  end

  def add_biker(biker)
    @bikers << biker
  end

  def most_rides
    @bikers.max_by { |biker| biker.rides.values.flatten.count }
  end

  def best_time(ride)
    bikers_have_ridden(ride).min_by { |biker| biker.personal_record(ride) }
  end

    def bikers_eligible(ride)
    @bikers.find_all do |biker|
      biker.acceptable_terrain.include?(ride.terrain) && biker.max_distance >= ride.total_distance
    end
  end

  def bikers_have_ridden(ride)
    @bikers.find_all { |biker| biker.rides.keys.include?(ride) }
  end
end
