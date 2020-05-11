class VendingMachine
  require './lib/drink.rb'

  AVAILABLE_MONEY = [10, 50, 100, 500, 1000].freeze

  #売上金額を確認
  attr_reader :proceeds

  def initialize
    @amount = [0]
    @stock = {}
    self.add_stock(Drink.cola)
    @proceeds = 0
  end

  #ドリンクの在庫を補充
  def add_stock(drink, stock=5)
    if @stock.has_key?(drink.name)
      @stock[drink.name][:stock] += stock
    else
      @stock[drink.name] = { price: drink.price, stock: stock }
    end
  end

  #お金を投入
  def insert(money)
    if AVAILABLE_MONEY.include?(money)
      @amount[0] += money
      total
    else
      money
    end
  end

  #投入金額を表示
  def total
    @amount[0]
  end

  #お釣りを出す(privateメソッドを呼び出し)
  def refund
    create_amount_box
    reset_amount_box
  end

  #自動販売機の在庫を表示する
  def stock_info
    @stock
  end

  #買えるドリンクのリストを表示
  def purchasable_drinks
    @stock.select do |key, value|
      @amount[0] >= value[:price] && value[:stock] > 0
    end.keys
  end

  #ドリンクが買えるか確認する
  def purchasable?(drink)
    self.purchasable_drinks.include?(drink)
  end

  #ドリンクを買う
  def purchase(drink)
    if self.purchasable?(drink)
      price = @stock[drink][:price]
      @amount[0] -= price
      @stock[drink][:stock] -= 1
      @proceeds += price
      [drink, self.refund]
    end
  end

  private

  #新しい貯金箱を作る
  def create_amount_box
    @amount[1] = 0
  end

  #古い貯金箱を壊し、中に入っていた金額をお釣りとして返金
  def reset_amount_box
    @amount.delete_at(0)
  end
end