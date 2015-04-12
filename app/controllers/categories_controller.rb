class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by(name: params[:name])
    @garments = @category.garments
  end

end
