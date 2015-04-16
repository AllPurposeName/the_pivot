class Sellers::GarmentsController < ApplicationController
  before_action :set_garment, only: [:show]

  def index
    @garments = Seller.find_by_slug(params[:slug]).garments.where(retired: false)
  end

  def show
    @garment = Garment.find(params[:id])
  end

  def new
    @garment = Garment.new
  end

  def create
    authorize! :edit, Garment
    @garment = Garment.new(garment_params)
    @garment.seller_id = current_user.userable_id
    if @garment.save
      flash[:newcomplete] = "#{@garment.name.humanize} created!"
      redirect_to owners_path
    else
      try_create_garment_again
      redirect_to new_seller_garment_path(slug: current_user.slug)
    end
  end

  def edit
    @garment = Garment.find(params[:id])
    authorize! :edit, @garment
  end

  def update
    @garment = Garment.find(params[:id])
    authorize! :update, @garment
    if @garment.update(garment_params)
      flash[:success] = "You have successfully updated #{@garment.name}."
      redirect_to owners_path
    else
      @garment
      try_create_garment_again
      flash[:danger] = "Please try editing #{@garment.name} again."
      redirect_to edit_seller_garment_path(slug: current_user.slug)
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

  def try_create_garment_again
    @garment = Garment.create(garment_params)
    @garment.errors.messages.each do |field, msg|
      flash[field] = "#{field.to_s.humanize} #{msg[0]}"
    end
  end

end
