require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/vendor'
require './lib/market'

class MarketTest < Minitest::Test
  def test_it_exists
    market = Market.new("South Pearl Street Farmers Market")
    assert_instance_of Market, market
  end

  def test_it_has_name
    market = Market.new("South Pearl Street Farmers Market")
    assert_equal "South Pearl Street Farmers Market", market.name
  end

  def test_it_starts_with_no_vendors
    market = Market.new("South Pearl Street Farmers Market")
    assert_equal [], market.vendors
  end

  def test_it_can_add_vendors
    market = Market.new("South Pearl Street Farmers Market")
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
    vendor_1.stock("Peaches", 35)
    vendor_1.stock("Tomatoes", 7)
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")
    vendor_2.stock("Banana Nice Cream", 50)
    vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    vendor_3 = Vendor.new("Palisade Peach Shack")
    vendor_3.stock("Peaches", 65)

    market.add_vendor(vendor_1)
    market.add_vendor(vendor_2)
    market.add_vendor(vendor_3)

    assert_equal [vendor_1, vendor_2, vendor_3], market.vendors
  end

  def test_it_can_return_vendor_names
    market = Market.new("South Pearl Street Farmers Market")
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
    vendor_1.stock("Peaches", 35)
    vendor_1.stock("Tomatoes", 7)
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")
    vendor_2.stock("Banana Nice Cream", 50)
    vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    vendor_3 = Vendor.new("Palisade Peach Shack")
    vendor_3.stock("Peaches", 65)

    market.add_vendor(vendor_1)
    market.add_vendor(vendor_2)
    market.add_vendor(vendor_3)

    expected = ["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"]
    assert_equal expected, market.vendor_names
  end

  def test_it_can_return_vendors_by_item
    market = Market.new("South Pearl Street Farmers Market")
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
    vendor_1.stock("Peaches", 35)
    vendor_1.stock("Tomatoes", 7)
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")
    vendor_2.stock("Banana Nice Cream", 50)
    vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    vendor_3 = Vendor.new("Palisade Peach Shack")
    vendor_3.stock("Peaches", 65)
    vendor_3.stock("Apples", 0)

    market.add_vendor(vendor_1)
    market.add_vendor(vendor_2)
    market.add_vendor(vendor_3)

    assert_equal [vendor_1, vendor_3], market.vendors_that_sell("Peaches")
    assert_equal [vendor_2], market.vendors_that_sell("Banana Nice Cream")
    assert_equal [], market.vendors_that_sell("Apples")
  end

  def test_it_can_return_all_items_sold
    market = Market.new("South Pearl Street Farmers Market")
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
    vendor_1.stock("Peaches", 35)
    vendor_1.stock("Tomatoes", 7)
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")
    vendor_2.stock("Banana Nice Cream", 50)
    vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    vendor_3 = Vendor.new("Palisade Peach Shack")
    vendor_3.stock("Peaches", 65)

    market.add_vendor(vendor_1)
    market.add_vendor(vendor_2)
    market.add_vendor(vendor_3)

    expected = ["Peaches", "Tomatoes", "Banana Nice Cream", "Peach-Raspberry Nice Cream"]
    assert_equal expected, market.item_list
  end

  def test_it_can_return_sorted_item_list
    market = Market.new("South Pearl Street Farmers Market")
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
    vendor_1.stock("Peaches", 35)
    vendor_1.stock("Tomatoes", 7)
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")
    vendor_2.stock("Banana Nice Cream", 50)
    vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    vendor_3 = Vendor.new("Palisade Peach Shack")
    vendor_3.stock("Peaches", 65)

    market.add_vendor(vendor_1)
    market.add_vendor(vendor_2)
    market.add_vendor(vendor_3)

    expected = ["Banana Nice Cream", "Peach-Raspberry Nice Cream", "Peaches", "Tomatoes"]
    assert_equal expected, market.sorted_item_list
  end

  def test_it_can_return_total_inventory
    market = Market.new("South Pearl Street Farmers Market")
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
    vendor_1.stock("Peaches", 35)
    vendor_1.stock("Tomatoes", 7)
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")
    vendor_2.stock("Banana Nice Cream", 50)
    vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    vendor_3 = Vendor.new("Palisade Peach Shack")
    vendor_3.stock("Peaches", 65)

    market.add_vendor(vendor_1)
    market.add_vendor(vendor_2)
    market.add_vendor(vendor_3)

    expected = {"Peaches"=>100, "Tomatoes"=>7, "Banana Nice Cream"=>50, "Peach-Raspberry Nice Cream"=>25}
    assert_equal expected, market.total_inventory
  end

  def test_selling_an_item_reduces_the_stock_of_the_first_vendor_with_that_item
   market = Market.new("South Pearl Street Farmers Market")

   vendor_1 = Vendor.new("Rocky Mountain Fresh")
   vendor_1.stock("Peaches", 35)
   vendor_1.stock("Tomatoes", 7)

   vendor_2 = Vendor.new("Ba-Nom-a-Nom")
   vendor_2.stock("Banana Nice Cream", 50)
   vendor_2.stock("Peach-Raspberry Nice Cream", 25)

   vendor_3 = Vendor.new("Palisade Peach Shack")
   vendor_3.stock("Peaches", 65)

   market.add_vendor(vendor_1)
   market.add_vendor(vendor_2)
   market.add_vendor(vendor_3)

   assert_equal true, market.sell("Peaches", 20)
   assert_equal 15, vendor_1.check_stock("Peaches")
 end

 def test_a_sale_can_reduce_the_inventory_of_multiple_vendors
   market = Market.new("South Pearl Street Farmers Market")

   vendor_1 = Vendor.new("Rocky Mountain Fresh")
   vendor_1.stock("Peaches", 35)
   vendor_1.stock("Tomatoes", 7)

   vendor_2 = Vendor.new("Ba-Nom-a-Nom")
   vendor_2.stock("Banana Nice Cream", 50)
   vendor_2.stock("Peach-Raspberry Nice Cream", 25)

   vendor_3 = Vendor.new("Palisade Peach Shack")
   vendor_3.stock("Peaches", 65)

   market.add_vendor(vendor_1)
   market.add_vendor(vendor_2)
   market.add_vendor(vendor_3)

   assert_equal true, market.sell("Peaches", 40)
   assert_equal 0, vendor_1.check_stock("Peaches")
   assert_equal 60, vendor_3.check_stock("Peaches")
 end

 def test_sell_returns_false_when_no_vendor_sells_the_item
   market = Market.new("South Pearl Street Farmers Market")

   vendor_1 = Vendor.new("Rocky Mountain Fresh")
   vendor_1.stock("Peaches", 35)
   vendor_1.stock("Tomatoes", 7)

   vendor_2 = Vendor.new("Ba-Nom-a-Nom")
   vendor_2.stock("Banana Nice Cream", 50)
   vendor_2.stock("Peach-Raspberry Nice Cream", 25)

   vendor_3 = Vendor.new("Palisade Peach Shack")
   vendor_3.stock("Peaches", 65)

   market.add_vendor(vendor_1)
   market.add_vendor(vendor_2)
   market.add_vendor(vendor_3)

   assert_equal false, market.sell("Onions", 1)
 end

 def test_sell_returns_false_when_the_market_does_not_have_the_requested_quantity
   market = Market.new("South Pearl Street Farmers Market")

   vendor_1 = Vendor.new("Rocky Mountain Fresh")
   vendor_1.stock("Peaches", 35)
   vendor_1.stock("Tomatoes", 7)

   vendor_2 = Vendor.new("Ba-Nom-a-Nom")
   vendor_2.stock("Banana Nice Cream", 50)
   vendor_2.stock("Peach-Raspberry Nice Cream", 25)

   vendor_3 = Vendor.new("Palisade Peach Shack")
   vendor_3.stock("Peaches", 65)

   market.add_vendor(vendor_1)
   market.add_vendor(vendor_2)
   market.add_vendor(vendor_3)

   assert_equal false, market.sell("Peaches", 200)
 end
end
