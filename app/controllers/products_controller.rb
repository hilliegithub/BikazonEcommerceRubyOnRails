class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart

      cartitem = { 'id' => params[:id].to_i, 'qty' => params[:quantity_param].to_i}
      #session[:cart] << id unless session[:cart].include? (id)

      #puts session[:cart].includes(:id).where('')
      session[:cart] << cartitem unless session[:cart].any? do |item| item['id'] == cartitem['id'] end
      #puts session[:cart]

      redirect_to root_path
    end

  #   def remove_from_cart
  #     id = params[:id].to_i
  #     cartitem = session[:cart].delete_if { |a| a['id'] == id}
  #     #puts cartitem
  #     #session[:cart].delete(cartitem)
  #     redirect_to root_path
  # end
end

