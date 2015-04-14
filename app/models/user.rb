class User < ActiveRecord::Base
  include ActiveModel::Validations
  has_secure_password
  has_many :orders
  has_many :order_garments, through: :orders
  has_many :garments, through: :orders
  belongs_to :userable, polymorphic: true

  enum role: %w(default admin)
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i},
                    uniqueness: true
  validates :full_name, presence: true
  validates :username, length: { minimum: 2, maximum: 32 }

  def store_name
    userable.store_name
  end

  def slug
    userable.slug
  end
end
