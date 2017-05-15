class Oystercard
  attr_reader :balance

  def initialize
    @balance = 0
  end

  BALANCE_LIMIT = 90

  def top_up(amount)
    fail "Maximum balance of £#{BALANCE_LIMIT} exceeded" if @balance + amount > BALANCE_LIMIT
    @balance += amount
  end
end
