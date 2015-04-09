class SessionsController < ApplicationController
  include ResetCart

  def new
    @user = User.new
  end

  def logout
    session.clear
    redirect_to root_path
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if !user
      return try_login_again
    end
    if user.admin? && user.authenticate(params[:session][:password])
      flash[:welcomeadmin] = "Welcome, #{user.username.capitalize}!"
      redirect_to '/admin/inventory'
      session[:user_id] = user.id
    elsif user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to :back
    else
      try_login_again
    end
  end

  private

  def user_params
    params.require(:session).permit(:username, :password)
  end

  def try_login_again
    @user = User.create(user_params.merge({full_name: "failed_login", email: "failed@example.com"}))
    @user.errors.messages.each do |field, msg|
      flash[field] = "#{field.to_s.humanize} #{msg[0]}"
    end
    redirect_to :back
  end
end
