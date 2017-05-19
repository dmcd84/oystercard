class Journey

  attr_reader :entry_station, :exit_station

  def initialize(entry_station, exit_station)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  PENALTY_FARE = 6
  MINIMUM_FARE = 2

  def complete?
    entry_station.name != :no_name && exit_station.name != :no_name
  end

  def started?
    entry_station.name != :no_name && exit_station.name == :no_name
  end

  def calculate_fare
     if complete?
       MINIMUM_FARE
    else
      PENALTY_FARE
    end
  end

end
