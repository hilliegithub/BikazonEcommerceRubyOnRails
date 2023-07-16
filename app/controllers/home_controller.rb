class HomeController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.all.shuffle.take(6)
  end
end
