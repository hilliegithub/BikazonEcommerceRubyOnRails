class ProductsController < ApplicationController
  def index
    @products = Product.all.page(params[:page])
  end

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

end

