class Sellers::CatsController < ApplicationController
  before_action :set_cat, only: [:show]

  def index
    @cats = Seller.find_by_slug(params[:slug]).cats
  end

  def show
  end

  private

  def set_cat
    @cat = Cat.find(params[:id])
  end

end
