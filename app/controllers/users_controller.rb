class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    unless @user.save
      try_signup_again
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

  private

  def user_params
    params.require(:user).permit(:username, :email, :full_name, :password)
  end

  def try_signup_again
    @user = User.create(user_params)
    @user.errors.messages.each do |field, msg|
      flash[field] = "#{field.to_s.humanize} #{msg[0]}"
    end
    redirect_to :back
  end

end
