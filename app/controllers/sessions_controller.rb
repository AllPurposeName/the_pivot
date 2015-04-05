class SessionsController < ApplicationController
  include ResetCart

  def new
  end

  def logout
    session[:user_id] = nil
    reset_cart
    redirect_to root_path
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if !user
      return try_again
    end
    if user.admin? && user.authenticate(params[:session][:password])
      flash[:welcomeadmin] = "Welcome, #{user.username.capitalize}!"
      redirect_to '/admin/inventory'
      session[:user_id] = user.id
    elsif user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
      if session[:order_cats_controller]
        redirect_to cart_path
      else
        redirect_to root_patah
      end
    else
      try_again
    end
  end

  private

  def try_again
    flash[:tryagain] = "Whoops, try again"
    render :new
  end
end
