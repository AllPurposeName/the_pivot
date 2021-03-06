class OrderGarmentsController < ApplicationController
  include ResetCart
  def create
    if current_user
      if @cart.garments_quantity
        order = current_user.orders.create
        @cart.create_order_garments(order)
        @cart.mail_purchase(current_user)
        reset_cart
        flash[:email] = "We sent you an email with order details!"
        redirect_to order_path(order.id)
      else
        redirect_to cart_path
      end
    else
      flash[:danger] = "Please login or sign up to continue checkout."
      session[:order_garments_controller] = request.env['PATH_INFO']
      redirect_to login_path
    end
  end
end
