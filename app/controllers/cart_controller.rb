class CartController < ApplicationController
  def index
    @products = Product.find(@cart.map { |a| a['id'] })

    @estimated = 0.0
    @cart.each do |item|
      @estimated += (item['qty'] * (@products.select {|p| p.id == item['id']}).first.price)
    end

    # If the signed in user has no primary or secondary address on file
    if account_signed_in?
      user = Account.find(current_account.id)
      if user.primary_province_id.present?
        @taxprovince = user.primary_province_id
      elsif user.secondary_province_id.present?
        @taxprovince = user.secondary_province_id
      else
        @taxprovince = nil
      end
    else
      if session[:province_id].present?
        @taxprovince = session[:province_id]
      else
        @taxprovince = nil
      end
    end

    # IF province is avaliable calculate the tax and display
    if !@taxprovince.nil?
      p = Province.find(@taxprovince)
      @tax = ((@estimated * (p.pst + p.gst + p.hst))/100)
    end

    #puts @cart.inspect
    #puts @estimated.inspect
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

  def remove_from_cart
    id = params[:id].to_i
    returnto = params[:where]
    puts returnto
    cartitem = session[:cart].delete_if { |a| a['id'] == id}

    if returnto == 'P'
      redirect_to root_path
    elsif returnto == 'C'
      redirect_to cart_path
    end
  end

end
