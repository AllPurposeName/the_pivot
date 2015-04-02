class HomeController < ApplicationController
  def show
  end

  def index
    set_top_sellers
    set_breeds
    set_top_cats
  end

  def items
    set_random_cats
  end

  def stores
    set_random_sellers
  end

  private

  def set_breeds
    @breeds = Breed.all
  end

  def set_top_cats
    @cats = Cat.top_20
  end

  def set_top_sellers
   @sellers = Seller.top_3
  end

  def set_random_cats
    @cats = Cat.order("RANDOM()")
  end

  def set_random_sellers
    @sellers = Seller.order("RANDOM()")
  end
end
