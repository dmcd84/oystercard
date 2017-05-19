require 'journeylog'

describe JourneyLog do

let (:journey) {double :journey }
let (:journey_class) {double :journey_class, :new => journey}
let (:station1) {double :station}
let (:subject) {JourneyLog.new(journey_class)}
it { is_expected.to respond_to(:start).with(1).argument }

it 'when you call start it should return a journey' do
  expect(subject.start(station1)). to eq journey
end

end
