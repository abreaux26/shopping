class Item
  attr_reader :name,
              :price

  def initialize(item_info)
    @name = item_info[:name]
    @price = item_info[:price]
  end

  def price
    @price.sub('$', '').to_f
  end
end
