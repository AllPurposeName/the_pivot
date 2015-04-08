class Cart
  include Monify
  attr_reader :contents, :cats_quantity, :price

  def initialize(cart_data)
    @contents = cart_data || Hash.new(0)
    update
  end

  def add_to_cart(cat)
    @contents[cat.to_s] ||= 0
    @contents[cat.to_s] += 1
  end

  def remove_from_cart(cat)
    @contents.delete(cat)
  end

  def subtract_from_cart(cat)
    @contents[cat.to_s] ||= 1
    @contents[cat.to_s] -= 1
    if @contents[cat.to_s] == 0
      @contents.delete(cat)
    end
  end

  def create_order_cats(order)
    @contents.each do |cat_id, quantity|
      order.order_cats.create(cat_id: cat_id,
                              quantity: quantity)
    end
  end

  def total_monify
    monify
  end

  def subtotal(cat)
    monify(@contents[cat.id.to_s] * Cat.find(cat).price)
  end

  private

  def update
    if no_content_empty?
      set_cats_quantity
      sum_price
    end
  end

  def no_content_empty?
    @contents.none? do |content|
      content[0].empty?
    end
  end

  def set_cats_quantity
    @cats_quantity = @contents.each_with_object(Hash.new(0)) do |(cat_id, quantity), hash|
    hash[Cat.find(cat_id)] = quantity
    end
  end

  def sum_price
    @price = cats_quantity.inject(0) do |sum, (item, quantity)|
      sum += (item.price * quantity)
      sum
    end
  end
end
