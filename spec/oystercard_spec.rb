require 'oystercard'

describe Oystercard do
  let(:entry_station) {double :station}
  let(:exit_station) {double :station}

    it 'has a an intial balance' do
      expect(subject.balance).to eq(0)
    end

    it 'has an empty list of journeys by default' do
      expect(subject.journeys).to be_empty
    end

    describe '#top_up' do
      it 'can top up the balance' do
        expect{ subject.top_up 10 }.to change{ subject.balance }.by 10
      end

      it 'raises and error if top_up exceeds the maximum monetary balance' do
        subject.top_up(Oystercard::BALANCE_LIMIT)
        expect{ subject.top_up 1 }.to raise_error "Maximum balance of £#{Oystercard::BALANCE_LIMIT} exceeded"
      end
    end

    describe '#touch_in' do
      before(:each) do
        subject.top_up(Oystercard::MINIMUM_BALANCE)
        subject.touch_in(:entry_station)
      end

      it 'allows a user to touch in' do
        expect(subject.entry_station).not_to eq nil
      end

      it 'remembers the entry station' do
        expect(subject.entry_station).to eq :entry_station
      end

      context 'insufficient funds on card' do
        let(:oystercard) { described_class.new }

        it 'will not touch in if balance is below minimum' do
          expect{ oystercard.touch_in(:entry_station) }.to raise_error "Insufficient balance to travel"
        end
      end
    end

    describe '#touch_out' do
      before(:each) do
        subject.top_up(Oystercard::BALANCE_LIMIT)
        subject.touch_in(:entry_station)
        subject.touch_out(:exit_station)
      end

      it 'allows a user to touch out' do
        expect(subject.entry_station).to eq nil
      end

      it 'deducts the fare from the balance of the oystercard' do
        expect{ subject.touch_out(:station) }.to change{ subject.balance }.by(-Oystercard::MINIMUM_FARE)
      end

      it 'touching in and out should create one journey' do
        expect(subject.journeys).to eq [{entry_station: :entry_station, exit_station: :exit_station}]
      end
    end
end
