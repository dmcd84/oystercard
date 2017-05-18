require 'oystercard'
require 'journey'
require 'station'

describe Oystercard do

  # before(:each) do
  #   card = Oystercard.new
  #   card.top_up(10)
  # end

  it 'recieves an entry station from journey when oystercard is touched in' do
    card = Oystercard.new
    card.top_up(10)
    station1 = Station.new(:entry_station, 1)
    station2 = Station.new(:exit_station, 3)
    journey = Journey.new(station1, station2)
    card.touch_in(journey)
    expect(journey.entry_station).to eq station1
  end

  it 'receieves an exit station from journey when oystercard is touched out' do
    card = Oystercard.new
    card.top_up(10)
    station1 = Station.new(:entry_station, 1)
    station2 = Station.new(:exit_station, 3)
    journey = Journey.new(station1, station2)
    card.touch_out(journey)
    expect(journey.exit_station).to eq station2
  end

  it 'is a completed journey when entry_station and exit_station are present' do
    card = Oystercard.new
    card.top_up(10)
    station1 = Station.new(:entry_station, 1)
    station2 = Station.new(:exit_station, 3)
    journey = Journey.new(station1, station2)
    card.touch_in(journey)
    expect(journey.complete?).to eq true
  end
end
