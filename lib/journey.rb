class Journey

  attr_accessor :entry_station, :exit_station

  def initialize(entry_station: nil)
    @entry_station = entry_station
    @complete = false
  end

  PENALTY_FARE = 6
  MINIMUM_FARE = 2

  def finish(station=nil)
    @complete = true
    @exit_station = station
  end

  def complete?
    @complete
  end

  def calculate_fare
    return PENALTY_FARE if penalty?
    MINIMUM_FARE
  end

  def penalty?
    (!entry_station || !exit_station)
  end
end
