class SearchController < ApplicationController
  def index
    @searchterm = params[:query]
    @searchCategory = params[:category]


      if params[:category] == "All"
        @products = Product.where("LOWER(productname) LIKE LOWER(?)", "%#{Product.sanitize_sql_like(params[:query])}%")
      else
        category =  Category.where(categoryname: "#{Category.sanitize_sql_like(params[:category])}")
        puts category.inspect
        @products = Product.joins(:category).where("LOWER(products.productname) LIKE LOWER(?) AND categories.id = ?", "%#{Product.sanitize_sql_like(params[:query])}%", category.pluck(:id))
      end
  end
end

