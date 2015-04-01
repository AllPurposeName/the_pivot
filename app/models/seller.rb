class Seller < ActiveRecord::Base
  has_one :user, as: :userable
  validates :slug, uniqueness: true
  before_save :generate_slug

  def generate_slug
    self.slug = store_name.parameterize
  end

  def name
    self.user.username
  end
end
