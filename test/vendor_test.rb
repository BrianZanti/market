require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/vendor'

class VendorTest < Minitest::Test
  def test_it_exists
    vendor = Vendor.new("Rocky Mountain Fresh")
    assert_instance_of Vendor, vendor
  end

  def test_it_has_name
    vendor = Vendor.new("Rocky Mountain Fresh")
    assert_equal "Rocky Mountain Fresh", vendor.name
  end

  def test_it_starts_with_no_inventory
    vendor = Vendor.new("Rocky Mountain Fresh")
    assert_equal ({}), vendor.inventory
  end

  def test_vendor_can_check_stock
    vendor = Vendor.new("Rocky Mountain Fresh")
    assert_equal 0, vendor.check_stock("Peaches")
  end

  def test_vendor_can_stock_items
    vendor = Vendor.new("Rocky Mountain Fresh")
    vendor.stock("Peaches", 30)
    vendor.stock("Peaches", 25)
    vendor.stock("Tomatoes", 12)
    assert_equal 55, vendor.check_stock("Peaches")
    assert_equal 12, vendor.check_stock("Tomatoes")
    assert_equal ({"Peaches"=>55, "Tomatoes"=>12}), vendor.inventory
  end

  def test_it_can_sell_an_item
    vendor = Vendor.new("Rocky Mountain Fresh")
    vendor.stock("Peaches", 24)
    vendor.sell("Peaches", 3)
    assert_equal 21, vendor.check_stock("Peaches")
  end

  def test_it_can_sell_its_whole_stock
    vendor = Vendor.new("Rocky Mountain Fresh")
    vendor.stock("Peaches", 24)
    vendor.sell("Peaches", 30)
    assert_equal 0, vendor.check_stock("Peaches")
  end

  def test_selling_will_return_the_amount_sold
    vendor = Vendor.new("Rocky Mountain Fresh")
    vendor.stock("Peaches", 24)
    assert_equal 3, vendor.sell("Peaches", 3)
    assert_equal 21, vendor.sell("Peaches", 30)
  end
end
