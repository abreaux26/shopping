require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/vendor'

class VendorTest < Minitest::Test
  def setup
    @vendor = Vendor.new("Rocky Mountain Fresh")
    @item1 = mock
    @item2 = mock
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

  def test_potential_revenue
    @item1.stubs(:price).returns(0.75)
    @item2.stubs(:price).returns(0.50)

    @vendor.stock(@item1, 35)
    @vendor.stock(@item2, 7)

    assert_equal 29.75, @vendor.potential_revenue
  end

  def test_inventory_items
    @vendor.stock(@item1, 35)
    @vendor.stock(@item2, 7)

    assert_equal [@item1, @item2], @vendor.inventory_items
  end

  def test_overstocked
    @vendor.stock(@item1, 30)
    @vendor.stock(@item1, 25)

    assert_equal true, @vendor.overstocked?(@item1)
  end
end
