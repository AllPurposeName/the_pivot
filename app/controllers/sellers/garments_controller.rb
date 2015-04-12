class Sellers::GarmentsController < ApplicationController
  before_action :set_garment, only: [:show]

  def index
    @garments = Seller.find_by_slug(params[:slug]).garments
  end

  def show
  end

  private

  def set_garment
    @garment = Garment.find(params[:id])
  end

end
