require 'journey'

describe Journey do
  let(:station1) {double :station}
  let(:station2) {double :station}
  subject(:journey) { described_class.new(entry_station: station1)}

  it 'has an entry station' do
    expect(journey.entry_station).to eq station1
  end

  it 'has an exit station' do
    expect(journey.finish(station2)).to eq station2
  end

  it 'knows if the current journey has started' do
    subject.entry_station = station1
    expect(subject.complete?).to eq false
  end

  it 'knows if the current journey is complete' do
    subject.entry_station = station1
    subject.finish(station2)
    expect(subject.complete?).to eq true
  end

  it 'charges penalty fare if a journey is incomplete due to no touch_in' do
    subject.entry_station = nil
    subject.finish(station2)
    expect(subject.calculate_fare).to eq Journey::PENALTY_FARE
  end

  it 'charges penalty fare if a journey is incomplete due to no touch_out' do
    subject.entry_station = station1
    subject.finish(nil)
    expect(subject.calculate_fare).to eq Journey::PENALTY_FARE
  end

  it 'charges minimum fare if a journey is complete' do
    subject.entry_station = station1
    subject.finish(station2)
    expect(journey.calculate_fare).to eq Journey::MINIMUM_FARE
  end

  it 'charges penalty if tapped in twice' do
    subject.entry_station = station1
    subject.finish(nil)
    subject.entry_station = station1
    expect(journey.calculate_fare).to eq Journey::PENALTY_FARE
  end

end
