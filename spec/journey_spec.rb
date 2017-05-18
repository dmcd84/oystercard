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

end
