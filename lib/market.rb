class Market
  attr_reader :name,
  :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.check_stock(item) > 0
    end
  end

  def item_list
    @vendors.map do |vendor|
      vendor.inventory.keys
    end.flatten.uniq
  end

  def sorted_item_list
    item_list.sort
  end

  def add_to_total_inventory(vendor, market_inventory)
    vendor.inventory.each do |item, quantity|
      market_inventory[item] += quantity
    end
    market_inventory
  end

  def total_inventory
    @vendors.inject(Hash.new(0)) do |market_inventory, vendor|
      add_to_total_inventory(vendor, market_inventory)
    end
  end

  def sell(item, quantity)
    return false if total_inventory[item] < quantity
    vendor = @vendors.find do |vendor|
      vendor.check_stock(item) > 0
    end
    amount_sold = vendor.sell(item, quantity)
    remaining_quantity = quantity - amount_sold
    if remaining_quantity > 0
      sell(item, remaining_quantity)
    end
    return true
  end
end
