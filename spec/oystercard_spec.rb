require 'oystercard'

describe Oystercard do
    it 'has a an intial balance' do
      expect(subject.balance).to eq(0)
    end

    describe '#top_up' do
      it 'can top up the balance' do
        expect{ subject.top_up 10 }.to change{ subject.balance }.by 10
      end

      it 'raises and error if top_up exceeds the maximum monetary balance' do
        max_balance = Oystercard::BALANCE_LIMIT
        subject.top_up(max_balance)
        expect{ subject.top_up 1 }.to raise_error "Maximum balance of £#{max_balance} exceeded"
      end
    end

    describe '#in_journey?' do
      it 'the oystercard should initially not be in use for ajourney' do
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
        min_balance = Oystercard::MINIMUM_BALANCE
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
        subject.touch_out
        expect(subject).not_to be_in_journey
      end
      it 'deducts the fare from the balance of the oystercard' do
        expect{ subject.touch_out }.to change{ subject.balance }.by (-Oystercard::MINIMUM_FARE)
      end
    end
end
