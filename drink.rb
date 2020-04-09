class Drink
  attr_reader :price, :stock

  def self.cola
    { cola: { price: 120, stock: 5 } }    
  end

end