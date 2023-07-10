class CartController < ApplicationController
  def index
    @products = Product.find(@cart.map { |a| a['id'] })
    puts @cart.inspect
  end

  def update
    puts params
    qty = params[:quantity_param].to_i
    id = params[:id].to_i

    # Check if the value is equal to zero. If so, remove the item from the cart.
    session[:cart].delete_if { |a| a['id'] == id && qty == 0 }

    # Otherwise, check if the value is different from what is already in the cart, and update accordingly.
    existing_item = session[:cart].find { |a| a['id'] == id }
    if existing_item
      existing_item['qty'] = qty
    else
      new_item = { 'id' => id, 'qty' => qty }
      session[:cart] << new_item
    end

    puts session[:cart]

    redirect_to cart_path
  end
end
