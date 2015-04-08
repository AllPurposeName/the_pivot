class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    unless @user.save
      flash[:danger] = "Please enter valid credenials."
      render :new
    else
      flash[:success] = "Now you can buy some natural, handmade clothes!"
      session[:user_id] = @user.id
      if session[:order_cats_controller]
        redirect_to cart_path
      else
        redirect_to root_path
      end
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :full_name, :password)
  end
end
