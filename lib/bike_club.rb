class BikeClub
  attr_reader :name,
              :bikers

  def initialize(name)
    @name = name
    @bikers = []
  end
end
