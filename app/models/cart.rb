class Cart
  include Monify
  attr_reader :contents, :garments_quantity, :price

  def initialize(cart_data)
    @contents = cart_data || Hash.new(0)
    update
  end

  def add_to_cart(garment)
    @contents[garment.to_s] ||= 0
    @contents[garment.to_s] += 1
  end

  def remove_from_cart(garment)
    @contents.delete(garment)
  end

  def subtract_from_cart(garment)
    @contents[garment.to_s] ||= 1
    @contents[garment.to_s] -= 1
    if @contents[garment.to_s] == 0
      @contents.delete(garment)
    end
  end

  def create_order_garments(order)
    @contents.each do |garment_id, quantity|
      order.order_garments.create(garment_id: garment_id,
                              quantity: quantity)
    end
  end

  def total_monify
    monify
  end

  def subtotal(garment)
    monify(@contents[garment.id.to_s] * garment.price)
  end

  def mail_purchase(recipient)
    mail_to_user(recipient)
    mail_to_sellers(recipient)
  end

  private

  def update
    if no_content_empty?
      set_garments_quantity
      sum_price
    end
  end

  def no_content_empty?
    @contents.none? do |content|
      content[0].empty?
    end
  end

  def set_garments_quantity
    @garments_quantity = @contents.each_with_object(Hash.new(0)) do |(garment_id, quantity), hash|
    hash[Garment.find(garment_id)] = quantity
    end
  end

  def sum_price
    @price = garments_quantity.inject(0) do |sum, (item, quantity)|
      sum += (item.price * quantity)
      sum
    end
  end

  def mail_to_user(recipient)
    Notifier.purchase_notification(recipient).deliver_now
  end

  def mail_to_sellers(recipient)
    sellers.each do |seller|
      Notifier.item_sold_notification(seller, recipient).deliver_now
    end
  end

  def sellers
    @contents.keys.map do |garment|
      Garment.find(garment).seller
    end.uniq
  end
end
