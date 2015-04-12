class Order < ActiveRecord::Base
  include Monify
  belongs_to :user, inverse_of: :orders
  has_many :order_garments
  has_many :garments, through: :order_garments, inverse_of: :orders

  enum status: %w(ordered paid completed cancelled)

  def price
    order_garments.inject(0) do |total, transaction|
      total + (transaction.quantity * transaction.garment.price)
    end
  end

  def total_monify
    monify
  end
end
