require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/market'

class MarketTest < Minitest::Test
  def setup
    @market = Market.new("South Pearl Street Farmers Market")
    @vendor1 = mock
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
end
