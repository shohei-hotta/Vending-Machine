class VendingMachine

  AVAILABLE_MONEY = [10, 50, 100, 500, 1000]

  def initialize
    @amount = [0]
    @stock = { cola: { price: 120, stock: 5 } }
    @sale_proceeds = 0
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

  #コーラが買えるか確認する
  def purchasable?(drink)
    if @amount[0] >= @stock[drink][:price]
      true
    else
      false
    end
  end

  #コーラを買う（※もっと綺麗に書けそう？）
  def purchase(drink)
    if self.purchasable?(drink)
      @amount[0] -= @stock[drink][:price] 
      @stock[drink][:stock] -= 1
      @sale_proceeds += @stock[drink][:price]
      drink
    else
      false
    end
  end

  #売上金額を表示する
  def sale_proceeds
    @sale_proceeds
  end
end