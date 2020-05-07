### How to use

```
$ irb

# ファイルを読み込み
> require "./lib/vending-machine.rb"

# 自動販売機の作成
> machine = VendingMachine.new

# 自動販売機の在庫確認
> machine.stock_info # => {:cola=>{:price=>120, :stock=>5}}

# 自動販売機にドリンクを補充
> machine.stock Drink.redbull
> machine.stock Drink.water
> machine.stock_info # => {:cola=>{:price=>120, :stock=>5}, :redbull=>{:price=>200, :stock=>5}, :water=>{:price=>100, :stock=>5}}

# 自動販売機に未対応のお金を投入
> machine.insert 1 # => 1
> machine.insert 5 # => 5

# 自動販売機に対応したお金を投入
> machine.insert 10 # => nil
> machine.insert 50 # => nil

# 投入金額を表示
> machine.total # => 60

# お釣りをもらう
> machine.refund # => 60
> machine.total # => 0

# 投入済みの金額で購入できるドリンクを確認
> machine.insert 100 # => nil
> machine.purchasable_drink_names # => [:water]
> machine.purchasable? :water # => true
> machine.purchasable? :cola # => false
> machine.purchasable? :redbull # => false

# ドリンクの購入操作（投入金額が足りない）
> machine.purchase :redbull # => false

> machine.insert 50 # => nil
> machine.purchasable_drink_names # => [:cola, :water]
> machine.purchasable? :cola # => true
> machine.insert 100 # => nil
> machine.purchasable_drink_names # => [:cola, :redbull, :water]
> machine.purchasable? :redbull # => true
> machine.total # => 250

# ドリンクの購入操作（投入金額が足りている）
> machine.purchase :redbull # => [:redbull, 50]

> machine.total # => 0
> machine.refund # => 0

# 自動販売機の売上を表示
> machine.proceeds # => 200

> machine.stock_info # => {:cola=>{:price=>120, :stock=>5}, :redbull=>{:price=>200, :stock=>4}, :water=>{:price=>100, :stock=>5}}
> exit
```