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
end
