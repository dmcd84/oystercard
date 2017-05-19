require 'journeylog'

describe JourneyLog do

#let (:journey) {double :journey }
let (:incomplete_journey) { double :journey}
let (:journey_class) {double :journey_class, :new => incomplete_journey}
let (:station1) {double :station}
let (:subject) {JourneyLog.new(journey_class)}
it { is_expected.to respond_to(:start).with(1).argument }

it 'when you call start it should return a journey' do
  expect(subject.start(station1)). to eq incomplete_journey
end

it 'can return an incomplete journey' do
  subject.start(station1)
  expect(subject.current_journey).to eq incomplete_journey
end
it 'creates a new journey if current_journey was complete' do
  subject.start(station1)
  subject.incomplete_journey = false
  expect(subject.current_journey).to eq incomplete_journey
end
end
