require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/market'

class MarketTest < Minitest::Test
  def setup
    @market = Market.new("South Pearl Street Farmers Market")
    @vendor1 = mock
    @vendor2 = mock
    @vendor3 = mock
    @item1 = mock("item1")
    @item2 = mock("item2")
    @item3 = mock("item3")
  end

  def add_vendors_to_market
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
  end

  def test_it_exists
    assert_instance_of Market, @market
  end

  def test_it_has_readable_attributes
    assert_equal "South Pearl Street Farmers Market", @market.name
    assert_equal [], @market.vendors
  end

  def test_add_vendor
    @market.add_vendor(@vendor1)
    assert_equal [@vendor1], @market.vendors
  end

  def test_market_vendor_names
    @vendor1.stubs(:name).returns("Rocky Mountain Fresh")
    @vendor2.stubs(:name).returns("Ba-Nom-a-Nom")
    @vendor3.stubs(:name).returns("Palisade Peach Shack")
    add_vendors_to_market

    expected = ["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"]
    assert_equal expected, @market.vendor_names
  end

  def test_vendors_that_sell
    add_vendors_to_market
    @vendor1.stubs(:inventory).returns({@item1 => 35}, {@item2 => 7})
    @vendor2.stubs(:inventory).returns({@item1 => 35})
    @vendor3.stubs(:inventory).returns({})

    expected = [@vendor1, @vendor2]

    assert_equal expected, @market.vendors_that_sell(@item1)
  end

  def test_quantity_per_item
    add_vendors_to_market
    @vendor1.stubs(:inventory).returns({@item1 => 35}, {@item2 => 7})
    @vendor1.stubs(:check_stock).returns(42)
    @vendor2.stubs(:inventory).returns({@item1 => 35})
    @vendor2.stubs(:check_stock).returns(35)
    @vendor3.stubs(:inventory).returns({@item3 => 10})

    assert_equal 77, @market.quantity_per_item(@item1)
  end

  def test_list_of_items
    add_vendors_to_market
    @vendor1.stubs(:inventory_items).returns([@item1, @item2])
    @vendor2.stubs(:inventory_items).returns([@item1])
    @vendor3.stubs(:inventory_items).returns([@item3])


    assert_equal [@item1, @item2, @item3], @market.list_of_items
  end

  def test_total_inventory
    add_vendors_to_market
    @vendor1.stubs(:check_stock).returns(7)
    @vendor2.stubs(:check_stock).returns(93)
    @vendor3.stubs(:check_stock).returns(50)
    #
    @vendor1.stubs(:inventory_items).returns([@item1, @item2])
    @vendor2.stubs(:inventory_items).returns([@item1])
    @vendor3.stubs(:inventory_items).returns([@item3])

    @market.stubs(:vendors_that_sell).with(@item1).returns([@vendor1, @vendor2])
    @market.stubs(:vendors_that_sell).with(@item2).returns([@vendor1])
    @market.stubs(:vendors_that_sell).with(@item3).returns([@vendor3])


    expected = {
      @item1 => { quantity: 100, vendors: [@vendor1, @vendor2]},
      @item2 => { quantity: 7, vendors: [@vendor1] },
      @item3 => { quantity: 50, vendors: [@vendor3] }
    }

    assert_equal expected, @market.total_inventory
  end
end
