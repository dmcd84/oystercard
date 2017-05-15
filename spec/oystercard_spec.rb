require 'oystercard'

describe Oystercard do
    it 'has a an intial balance' do
      expect(subject.balance).to eq(0)
    end
end
