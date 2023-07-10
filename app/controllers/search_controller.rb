class SearchController < ApplicationController
  def index
    @searchterm = params[:query]
    @products = Product.where("LOWER(productname) LIKE LOWER(?)", "%#{Product.sanitize_sql_like(params[:query])}%")
  end
end
