class JourneyLog
attr_accessor :incomplete_journey
  def initialize(journey_class)
    @journey_class = journey_class
  end

  def start(entry_station)
    @incomplete_journey = @journey_class.new(entry_station)
  end

  def current_journey
    @incomplete_journey ||= @journey_class.new
  end
end
