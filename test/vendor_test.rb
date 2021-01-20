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
end
