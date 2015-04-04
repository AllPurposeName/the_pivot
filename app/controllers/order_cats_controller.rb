class OrderCatsController < ApplicationController
  include ResetCart
  def create
    if current_user
      if @cart.cats_and_quantity
        order = current_user.orders.create
        @cart.create_order_cats(order)
        reset_cart
        redirect_to order_path(order.id)
      else
        redirect_to cart_path
      end
    else
      flash[:danger] = "Please login or sign up to continue checkout."
      redirect_to login_path
    end
  end
end
