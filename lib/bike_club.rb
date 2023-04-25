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
    have_ridden(ride).min_by { |biker| biker.personal_record(ride) }
  end

  def have_ridden(ride)
    @bikers.find_all { |biker| biker.rides.keys.include?(ride) }
  end
end
