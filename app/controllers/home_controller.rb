class HomeController < ApplicationController
  before_action :set_top_cats, :set_breeds, :set_top_sellers
  def show

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
end
