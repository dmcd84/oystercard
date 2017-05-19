require_relative 'station'
require_relative 'journey'
class Oystercard
  attr_reader :balance, :entry_station, :journeys

  def initialize
    @balance = 0
    @entry_station = nil
    @journeys = []
    @in_use = nil
  end

  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 2

  def top_up(amount)
    raise "Maximum balance of £#{BALANCE_LIMIT} exceeded" if @balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    Journey.new
    calculate_fare if @in_use == true
    raise 'Insufficient balance to travel' if @balance < MINIMUM_BALANCE
    @entry_station = entry_station
    @in_use = true
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @journeys << { entry_station: entry_station, exit_station: exit_station }
    @entry_station = nil
    @in_use = false
  end

  def in_journey?
    @in_use
  end

  private

  def deduct(fare)
    @balance -= fare
  end
end
