class Sellers::DashboardController < ApplicationController

  def show
    @seller = Seller.find_by(slug: params[:slug])
  end


end
