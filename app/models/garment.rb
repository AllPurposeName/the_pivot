class Garment < ActiveRecord::Base
  include ActiveModel::Validations
  include AttributeUpdater
  include Monify
  has_many :garment_breeds
  has_many :breeds, through: :garment_breeds, inverse_of: :garments
  has_many :order_garments, inverse_of: :garment
  has_many :orders, through: :order_garments, inverse_of: :garments
  has_many :users, through: :orders, inverse_of: :garments
  belongs_to :seller

  validates :name, length: { minimum: 2, maximum: 32 }
  validates_uniqueness_of :name
  validates :price, presence: true
  validates :description, presence: true

  def availability
    if !retired
      return "Available!"
    else
      "Sold out!"
    end
  end

  def quantity(order_id)
    Order.find(order_id).order_garments.find_by(garment_id: id).quantity
  end

  def change_retired
    self.retired = !self.retired
  end

  def self.top_20
    self.order("RANDOM()").limit(20)
  end

  def slug
    self.seller.slug
  end
end
