require 'journey'

describe Journey do
  subject(:journey) { described_class.new }

  it 'has an entry station' do
    station1 = Station.new(:entry_station, 1)
    station2 = Station.new(:exit_station, 3)
    journey = Journey.new(station1, station2)
    expect(journey.entry_station).to eq station1
  end

  it 'has an exit station' do
    station1 = Station.new(:entry_station, 1)
    station2 = Station.new(:exit_station, 3)
    journey = Journey.new(station1, station2)
    expect(journey.exit_station).to eq station2
  end

  it 'knows if the current journey is complete' do
    station1 = Station.new(:entry_station, 1)
    station2 = Station.new(:exit_station, 3)
    journey = Journey.new(station1, station2)
    expect(journey.complete?).to eq true
  end

  it 'knows if the current journey is complete' do
    station1 = Station.new(:entry_station, 1)
    station2 = Station.new(:no_name, 3)
    journey = Journey.new(station1, station2)
    expect(journey.complete?).to eq false
  end

  it 'charges penalty fare if a journey is incomplete' do
    station1 = Station.new(:no_name, :no_zone)
    station2 = Station.new(:exit_station, 3)
    journey = Journey.new(station1, station2)
    expect(journey.calculate_fare).to eq Journey::PENALTY_FARE
  end

  it 'charges minimum fare if a journey is complete' do
    station1 = Station.new(:entry_station, 2)
    station2 = Station.new(:exit_station, 3)
    journey = Journey.new(station1, station2)
    expect(journey.calculate_fare).to eq Journey::MINIMUM_FARE
  end


end
