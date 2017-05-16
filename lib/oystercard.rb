class Oystercard
  attr_reader :balance, :in_use

  def initialize
    @balance = 0
    @in_use = false
  end

  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 1

  def top_up(amount)
    fail "Maximum balance of £#{BALANCE_LIMIT} exceeded" if @balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in
    fail "Insufficient balance to travel" if @balance < MINIMUM_BALANCE
    @in_use = true
  end

  def touch_out
    @in_use = false
  end

  def in_journey?
    @in_use? true : false
  end
end
