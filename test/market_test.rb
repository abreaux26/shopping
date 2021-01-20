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
    @item1 = mock
    @item2 = mock
    @vendor1.stubs(:stock).returns({@item1 => 35}, {@item2 => 7})
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
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    expected = ["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"]
    assert_equal expected, @market.vendor_names
  end
end
