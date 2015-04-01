class Seller < ActiveRecord::Base
  has_one :user, as: :userable

  def name
    self.user.username
  end
end
