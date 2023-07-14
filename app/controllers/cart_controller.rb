class CartController < ApplicationController
  def index
    @products = Product.find(@cart.map { |a| a['id'] })

    @estimated = 0.0
    @cart.each do |item|
      @estimated += (item['qty'] * (@products.select {|p| p.id == item['id']}).first.price)
    end
    puts @cart.inspect
    puts @estimated.inspect
  end

  def update
    puts params
    qty = params[:quantity_param].to_i
    id = params[:id].to_i

    cart = session[:cart].select { |a| a['id'] != id }
    session[:cart] = cart

    # Check if the value is different from what is already in the cart, and update accordingly.
    existing_item = session[:cart].find { |a| a['id'] == id }
    if existing_item
      existing_item['qty'] = qty
    else
      new_item = { 'id' => id, 'qty' => qty }
      session[:cart] << new_item
    end

    # Remove the item from the cart if the quantity becomes zero
    session[:cart].delete_if { |a| a['id'] == id && a['qty'] == 0 }

    redirect_to cart_path
  end

end
