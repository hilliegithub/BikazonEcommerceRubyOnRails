class ApplicationController < ActionController::Base
    before_action :initialize_session
    before_action :load_cart
    before_action :set_dropdown_options

  private
  def initialize_session
    session[:cart] ||= []
  end

  def load_cart
    #puts session[:cart]
    @cart = session[:cart]
  end

  def set_dropdown_options
    @search_categories = Category.pluck(:categoryname)
    @categories = Category.all
  end
end
