require "vending-machine"

describe "自動販売機" do
  before do
    @machine = VendingMachine.new
  end

  context "指定された金額のみ投入された場合" do
    it "1円を投入できない" do
      expect(@machine.insert 1).to eq 1
    end

    it "5円を投入できない" do
      expect(@machine.insert 5).to eq 5
    end

    it "5000円を投入できない" do
      expect(@machine.insert 5000).to eq 5000
    end

    it "100000円を投入できない" do
      expect(@machine.insert 10000).to eq 10000
    end

    it "10円を投入できる" do
      @machine.insert 10
      expect(@machine.total).to eq 10
    end

    it "50円を投入できる" do
      @machine.insert 50
      expect(@machine.total).to eq 50
    end

    it "100円を投入できる" do
      @machine.insert 100
      expect(@machine.total).to eq 100
    end
    it "500円を投入できる" do
      @machine.insert 500
      expect(@machine.total).to eq 500
    end

    it "1000円を投入できる" do
      @machine.insert 1000
      expect(@machine.total).to eq 1000
    end
  end

  context "指定された金額が複数回投入された場合" do
    it "投入できる" do
      @machine.insert 10
      @machine.insert 100
      @machine.insert 10
      expect(@machine.total).to eq 120
    end
  end

  context "500円が投入された場合" do
    before do
      @machine.insert 500
    end

    it "お釣りボタンを押すとお釣りが返ってくる" do
      expect(@machine.refund).to eq 500
    end

    it "お釣りボタンを押すと投入金額が0になる" do
      @machine.refund
      expect(@machine.total).to eq 0
    end
  end

  context "在庫管理" do
    it "初期状態でコーラが5本格納されている" do
      expect(@machine.stock_info).to eq :cola => {:price=>120, :stock=>5}
    end

    it "指定されたドリンクと本数を格納できる" do
      @machine.add_stock(Drink.redbull, 10)
      expect(@machine.stock_info).to include :redbull=>{:price=>200, :stock=>10}
    end

    it "在庫を確認できる" do
      @machine.add_stock(Drink.water, 1)
      @machine.add_stock(Drink.redbull, 1)
      @machine.add_stock(Drink.water, 2)
      @machine.add_stock(Drink.redbull, 2)
      expect(@machine.stock_info).to eq :cola => {:price=>120, :stock=>5}, :redbull => {:price=>200, :stock=>3}, :water => {:price=>100, :stock=>3}
    end
  end

  context "投入金額が不足している場合" do
    before do
      @machine.insert 100
    end

    it "買えるドリンクのリストが表示されない" do
      expect(@machine.purchasable_drinks).to eq []
    end

    it "指定したドリンクが買えるか確認した場合、falseが出力される" do
      expect(@machine.purchasable?(:cola)).to be false
    end

    it "指定したドリンクの購入操作時、何も起きない" do
      expect(@machine.purchase(:cola)).to be nil
    end
  end

  context "投入金額が足りている場合" do
    before do
      @machine.insert 100
    end

    context "在庫が足りない場合" do
      it "買えるドリンクのリストが表示されない" do
        expect(@machine.purchasable_drinks).to eq []
      end

      it "指定したドリンクが買えるか確認した場合、falseが出力される" do
        expect(@machine.purchasable?(:water)).to be false
      end
  
      it "指定したドリンクの購入操作時、何も起きない" do
        expect(@machine.purchase(:water)).to be nil
      end
    end

    context "在庫が足りる場合" do
      before do
        @machine.add_stock(Drink.water)
      end

      it "買えるドリンクのリストが表示される" do
        expect(@machine.purchasable_drinks).to eq [:water]
      end

      it "指定したドリンクが買えるか確認した場合、trueが出力される" do
        expect(@machine.purchasable?(:water)).to be true
      end
  
      it "指定したドリンクの購入操作ができる" do
        expect(@machine.purchase(:water)).to eq [:water, 0]
      end
    end
  end

  context "コーラを1本購入した場合" do
    before do
      @machine.insert 500
      @machine.purchase(:cola)
    end

    it "売り上げ金額が増えている" do
      expect(@machine.proceeds).to eq 120
    end

    it "投入金額が０になる" do
      expect(@machine.total).to eq 0
    end

    it "コーラの在庫が1本減っている" do
      expect(@machine.stock_info).to eq :cola => {:price=>120, :stock=>4}
    end
  end
end