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

    describe '#deduct' do
      it 'can deduct a fare from the card balance' do
        expect{ subject.deduct 2.40 }.to change{ subject.balance }.by -2.40
      end
    end

    describe '#in_journey?' do
      it 'the oystercard should initially not be in use for ajourney' do
        expect(subject).not_to be_in_journey
      end
    end

    describe '#touch_in' do
      it 'allows a user to touch in' do
        subject.touch_in
        expect(subject).to be_in_journey
      end
    end

    describe '#touch_out' do
      it 'allows a user to touch out' do
        subject.touch_out
        expect(subject).not_to be_in_journey
      end
    end
end
