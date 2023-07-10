class CartController < ApplicationController
  def index
    @products = Product.find(@cart.map { |a| a['id'] })
  end
end
