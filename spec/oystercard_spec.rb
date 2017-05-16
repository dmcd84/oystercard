require 'oystercard'

describe Oystercard do
    it 'has a an intial balance' do
      expect(subject.balance).to eq(0)
    end

    it 'has an empty list of journeys by default' do
      expect(subject.journeys).to eq []
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

    describe '#in_journey?' do
      it 'the oystercard should initially not be in use for a journey' do
        expect(subject).not_to be_in_journey
      end
    end

    describe '#touch_in' do
      it 'allows a user to touch in' do
        subject.top_up(Oystercard::MINIMUM_BALANCE)
        subject.touch_in(:entry_station)
        expect(subject).to be_in_journey
      end
      it 'will not touch in if blance it below minimum' do
        expect{ subject.touch_in(:entry_station) }.to raise_error "Insufficient balance to travel"
      end
      it 'remembers the entry station' do
        subject.top_up(Oystercard::MINIMUM_BALANCE)
        subject.touch_in(01)
        expect(subject.entry_station).to eq 01
      end
    end

    describe '#touch_out' do
      it 'allows a user to touch out' do
        subject.top_up(Oystercard::BALANCE_LIMIT)
        subject.touch_in(:station)
        subject.touch_out(:station)
        expect(subject).not_to be_in_journey
      end
      it 'deducts the fare from the balance of the oystercard' do
        expect{ subject.touch_out(:station) }.to change{ subject.balance }.by (-Oystercard::MINIMUM_FARE)
      end
    end

    describe '#journeys' do
      it 'touching in and out should create one journey' do
        subject.top_up(Oystercard::BALANCE_LIMIT)
        subject.touch_in(:Paddington)
        subject.touch_out(:Oxford_Circus)
        expect(subject.journeys).to eq [{entry_station: :Paddington, exit_station: :Oxford_Circus}]
      end
    end
end
