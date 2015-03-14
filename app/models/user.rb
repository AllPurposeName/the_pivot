class User < ActiveRecord::Base
  include ActiveModel::Validations

  has_secure_password
  has_many :orders
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i},
                    uniqueness: true
end
