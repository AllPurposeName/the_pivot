class SellersController < ApplicationController
  def index
    seller_id = current_user.userable_id
    @garments = Garment.where(seller_id: seller_id)
  end

  def new
    unless current_user
      flash[:success] = "Please sign or log in to continue."
      redirect_to :back
    end
    @seller = Seller.new
  end

  def create
    seller = Seller.create(seller_params)
    current_user.update(userable_id: seller.id, userable_type: "Seller")
    flash[:success] = "Now you can start selling on #{seller.store_name}."
    redirect_to current_user
  end

  def seller_params
    params.require(:seller).permit(:store_name)
  end
end
