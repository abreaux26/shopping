class Vendor
  attr_reader :name,
              :inventory

  def initialize(name)
    @name = name
    @inventory = {}
  end

  def check_stock(item)
    return 0 if @inventory[item].nil?
    @inventory[item]
  end

  def stock(item, num_of_stock)
    @inventory[item] = check_stock(item) + num_of_stock
  end

  def potential_revenue
    inventory_items.sum do |item|
      item.price * check_stock(item)
    end
  end

  def inventory_items
    @inventory.keys
  end

  def overstocked?(item)
    check_stock(item) > 50
  end
end
