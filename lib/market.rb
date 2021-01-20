require 'date'

class Market
  attr_reader :name,
              :vendors,
              :date

  def initialize(name)
    @name = name
    @vendors = []
    @date = Date.today.strftime('%d/%m/%Y')
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

  def overstocked?(item, vendors_array)
    vendors_array.any? do |vendor|
      vendor.overstocked?(item)
    end
  end

  def vendors_per_item
     list_of_items.each_with_object({}) do |item, vendors_per_item|
       vendors_per_item[item] = vendors_that_sell(item)
     end
  end

  def overstocked_items
    vendors_per_item.select do |item, vendors_array|
      vendors_array.length > 1 && overstocked?(item, vendors_array)
    end.keys
  end

  def item_names_per_vendor
    @vendors.flat_map(&:sorted_inventory_items).uniq
  end

  def sorted_item_list
    item_names_per_vendor.sort
  end

  def sell(item, quantity)
    quantity_per_item(item) > quantity
  end
end
