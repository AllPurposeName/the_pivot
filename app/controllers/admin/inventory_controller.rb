class Admin::InventoryController < ApplicationController
  before_action :set_garments, :set_categorys
  def index
    authorize! :edit, Category
  end

  private

  def set_garments
    @garments = Garment.all
  end

  def set_categorys
    @categories = Category.all
  end

end
