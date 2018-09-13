class Vendor
  attr_reader :name,
  :inventory

  def initialize(name)
    @name = name
    @inventory = {}
  end

  def check_stock(item)
    if @inventory[item].nil?
      return 0
    else
      return @inventory[item]
    end
  end

  def stock(name, quantity)
    @inventory[name] = check_stock(name) + quantity
  end

  def sell(item, quantity)
    if check_stock(item) < quantity
      amount_to_sell = check_stock(item)
    else
      amount_to_sell = quantity
    end
    @inventory[item] -= amount_to_sell
    return amount_to_sell
  end
end
