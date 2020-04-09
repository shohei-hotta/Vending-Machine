class VendingMachine

  AVAILABLE_MONEY = [10, 50, 100, 500, 1000]

  def initialize
    @amount = [0, 0]
  end

  def insert(money)
    if AVAILABLE_MONEY.include?(money)
      @amount[0] += money
      nil
    else
      money
    end
  end

  def total
    @total = @amount.inject(0) { |result, n| result + n }
  end

  def refund
    @amount[2] = 0
    @amount.delete_at(0)
  end 
end