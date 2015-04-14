class Sellers::GarmentsController < ApplicationController
  before_action :set_garment, only: [:show]

  def index
    @garments = Seller.find_by_slug(params[:slug]).garments
  end

  def show
    @garment = Garment.find(params[:id])
  end

  def new
    @garment = Garment.new
  end

  def create
    #authorize! :create, Garment
    @garment = Garment.new(garment_params)
    @garment.seller_id = current_user.userable_id
    if @garment.save
      flash[:newcomplete] = "#{@garment.name.humanize} created!"
      redirect_to owners_path
    else
      flash[:newfail] = "Please fill every field in with a valid entry"
      redirect_to new_seller_garment_path(slug: current_user.slug)
    end
  end

  def edit
    @garment = Garment.find(params[:id])
  end

  def update
    garment = Garment.find(params[:id])
    if garment.update(garment_params)
      flash[:success] = "You have successfully updated #{garment.name}."
      redirect_to owners_path
    else
      flash[:danger] = "Please try editing #{garment.name} again."
      render :edit
    end
  end

  private
  def garment_params
    params.require(:garment).permit(:name,
                                :description,
                                :image_path,
                                :retired,
                                :price)
  end

  def set_garment
    @garment = Garment.find(params[:id])
  end

end
