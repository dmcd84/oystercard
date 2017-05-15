require 'oystercard'

describe Oystercard do
    it 'has a an intial balance' do
      expect(subject.balance).to eq(0)
    end

    describe '#top_up' do
      it { is_expected.to respond_to(:top_up).with(1).argument }

      it 'can top up the balance' do
        expect{ subject.top_up 10 }.to change{ subject.balance }.by 10
      end

      it 'raises and error if top_up exceeds the maximum monetary balance' do
        max_balance = Oystercard::BALANCE_LIMIT
        subject.top_up(max_balance)
        expect{ subject.top_up 1 }.to raise_error "Maximum balance of £#{max_balance} exceeded"
      end
    end
end
