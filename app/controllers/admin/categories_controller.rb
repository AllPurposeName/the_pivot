class Admin::CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update]

  def show
    authorize! :create, Category
  end

  def new
    authorize! :create, Category
    @category = Category.new
  end

  def create
    authorize! :create, Category
    @category = Category.new(breed_params)
    if @category.save
      flash[:newcomplete] = "#{@category.name.humanize} created!"
      redirect_to admin_category_path(@breed)
    else
      flash[:newfail] = "Please fill every field in with a valid entry"
      redirect_to new_admin_category_path
    end
  end

  def edit
    authorize! :create, Category
  end

  def update
    authorize! :create, Category
    sanitize_category_name
    @category.update_some_attributes(params[:breed])
    flash[:editcomplete] = "#{@category.name.humanize} edited!"
    redirect_to edit_admin_category_path(@breed.to_param)
  end

  def category_params
    params.require(:category).permit(:name, :description, :image_path, :retired)
  end

  private

  def sanitize_category_name
    params[:category][:name].downcase
  end

  def set_category
    @category = Category.find_by(name: params[:id].humanize)
  end
end
