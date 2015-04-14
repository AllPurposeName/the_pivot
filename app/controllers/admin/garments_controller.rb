class Admin::GarmentsController < ApplicationController
  respond_to :html, :json
  before_action :set_garment, only: [:show, :edit, :update]

  def show
    authorize! :read, Garment
  end

  def new
    authorize! :create, Garment
    @garment = Garment.new
  end

  def create
    authorize! :create, Garment
    @garment = Garment.new(garment_params)
    if @garment.save
      flash[:newcomplete] = "#{@garment.name.humanize} created!"
      redirect_to admin_garment_path(@garment)
    else
      flash[:newfail] = "Please fill every field in with a valid entry"
      redirect_to new_admin_garment_path
    end
  end

  def edit
    authorize! :update, Garment
  end

  def update
    authorize! :update, Garment
    sanitize_garment_name
    @garment.update_some_attributes(params[:garment])
    flash[:editcomplete] = "#{@garment.name.humanize} edited!"
    redirect_to edit_admin_garment_path(@garment.to_param)
  end

  def retired_update
    garment = Garment.find(params[:id])
    garment.change_retired
    render :json => "we good!", :status => :ok
  end

  def garment_params
    params.require(:garment).permit(:name,
                                :description,
                                :image_path,
                                :retired,
                                :price)
  end

  private

  def set_garment
    @garment = Garment.find(params[:id])
  end

  def sanitize_garment_name
    params[:garment][:name].downcase
  end
end
