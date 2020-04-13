class VendingMachine
  require './drink.rb'

  AVAILABLE_MONEY = [10, 50, 100, 500, 1000].freeze

  def initialize
    @amount = [0]
    @stock = {}
    self.stock(Drink.cola)
    @proceeds = 0
  end

  #ドリンクの在庫を補充
  def stock(drink)
    if @stock.has_key?(drink.name)
      @stock[drink.name][:stock] += 5
    else
      @stock[drink.name] = { price: drink.price, stock: 5 }
    end
  end

  #お金を投入
  def insert(money)
    if AVAILABLE_MONEY.include?(money)
      @amount[0] += money
      nil
    else
      money
    end
  end

  #投入金額を表示
  def total
    @amount[0]
  end

  #お釣りを出す
  def refund
    @amount[1] = 0
    @amount.delete_at(0)
  end

  #自動販売機の在庫を表示する（※商品名と在庫だけ表示するようにしたい。）
  def stock_info
    @stock
  end

  #買えるドリンクのリストを表示
  def purchasable_drink_names
    @stock_drink_names = @stock.keys
    n = 0
    @stock.values.each do |drink|
      if @amount[0] < drink[:price] || drink[:stock] == 0
        @stock_drink_names.delete_at(n)
      else
        n += 1
      end
    end
    @stock_drink_names
  end

  #ドリンクが買えるか確認する
  def purchasable?(drink)
    if @amount[0] >= @stock[drink][:price] && @stock[drink][:stock] > 0
      true
    else
      false
    end
  end

  #ドリンクを買う
  def purchase(drink)
    if self.purchasable?(drink)
      price = @stock[drink][:price]
      @amount[0] -= price
      @stock[drink][:stock] -= 1
      @proceeds += price
      [drink, self.refund]
    else
      false
    end
  end

  #売上金額を表示する
  def proceeds
    @proceeds
  end
end