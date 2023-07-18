class HomeController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.all.shuffle.take(6)

    # Product is new if created date and updated date is within the last 3 days
    @newproducts = Product.where('created_at >= ?', 3.days.ago.to_date).where("strftime('%Y-%m-%dT%H:%M:00', created_at) = strftime('%Y-%m-%dT%H:%M:00', updated_at)")


    # Product is updated if updated date is within the last 3 days
    @updatedproducts = Product.where('updated_at >= ?', 3.days.ago).where("strftime('%Y-%m-%dT%H:%M:00', created_at) != strftime('%Y-%m-%dT%H:%M:00', updated_at)")
                              #.shuffle.order('updated_at DESC')
  end
end
