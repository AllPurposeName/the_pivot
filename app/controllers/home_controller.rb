class HomeController < ApplicationController
  def show
  end

  def index
    set_top_sellers
    set_categories
    set_top_garments
  end

  def items
    set_random_garments
  end

  def stores
    set_random_sellers
  end

  private

  def set_categories
    @categories = Category.all
  end

  def set_top_garments
    @garments = Garment.top_20
  end

  def set_top_sellers
    @sellers = Seller.last(3)
  end

  def set_random_garments
    @garments = Garment.where(retired: false).order("RANDOM()")
  end

  def set_random_sellers
    @sellers = Seller.order("RANDOM()")
  end
end
