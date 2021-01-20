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
    @vendors.map(&:name)
  end

  def vendors_that_sell(item)
    @vendors.select do |vendor|
      vendor.inventory.include? item
    end
  end

  def list_of_items
    @vendors.flat_map(&:inventory_items).uniq
  end

  def quantity_per_item(item)
    vendors_that_sell(item).sum do |vendor|
      vendor.check_stock(item)
    end
  end

  def inventory(item)
    {
      quantity: quantity_per_item(item),
      vendors: vendors_that_sell(item)
    }
  end

  def total_inventory
    list_of_items.each_with_object({}) do |item, total_inventory_hash|
      total_inventory_hash[item] = inventory(item)
    end
  end
end
