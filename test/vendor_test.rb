require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/vendor'

class VendorTest < Minitest::Test
  def setup
    @vendor = Vendor.new("Rocky Mountain Fresh")
    @item1 = mock
  end

  def test_it_exists
    assert_instance_of Vendor, @vendor
  end

  def test_it_has_readable_attributes
    assert_equal "Rocky Mountain Fresh", @vendor.name
    expected = {}
    assert_equal expected, @vendor.inventory
  end

  def test_check_stock_without_inventory
    assert_equal 0, @vendor.check_stock(@item1)
  end

  def test_check_stock_with_item_inventory
    @vendor.stock(@item1, 30)
    assert_equal 30, @vendor.check_stock(@item1)
  end

  def test_stock
    @vendor.stock(@item1, 30)

    expected = { @item1 => 30 }

    assert_equal expected, @vendor.inventory
  end

  def test_add_num_of_stock_to_inventory
    @vendor.stock(@item1, 30)
    @vendor.stock(@item1, 25)

    expected = { @item1 => 55 }
    assert_equal expected, @vendor.inventory
  end
end
