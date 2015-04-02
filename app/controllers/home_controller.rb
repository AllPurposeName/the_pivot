class HomeController < ApplicationController
  before_action :set_cats, :set_breeds
  def show
  end

  def items
    set_random_cats
  end

  private

  def set_breeds
    @breeds = Breed.all
  end

  def set_cats
    @cats = Cat.all
  end

  def set_random_cats
    @cats = Cat.order("RANDOM()")
  end
end
