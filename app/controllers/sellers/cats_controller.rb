class Sellers::CatsController < ApplicationController
  before_action :set_cat, only: [:show]

  def index
    @cats = Seller.find_by_slug(params[:slug]).cats
    #num_in_column, extra = cats.length.divmod(3)
    #cats_column_1 = cats[0..num_in_column - 1]
    #cats_column_2 = cats[num_in_column..num_in_column * 2 - 1]
    #cats_column_3 = cats[num_in_column * 2..num_in_column * 3 + extra - 1]
    #@columns = [cats_column_1, cats_column_2, cats_column_3]
  end

  def show
  end

  private

  def set_cat
    @cat = Cat.find(params[:id])
  end

end
