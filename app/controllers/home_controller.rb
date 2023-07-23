class HomeController < ApplicationController
  def index
    @products = Product.all.shuffle.take(6)

    # Product is new if created date and updated date is within the last 3 days
    @newproducts = Product.where('created_at >= ?', 3.days.ago.to_date).where("strftime('%Y-%m-%dT%H:%M:00', created_at) = strftime('%Y-%m-%dT%H:%M:00', updated_at)").take(3)


    # Product is updated if updated date is within the last 3 days
    @updatedproducts = Product.where('updated_at >= ?', 3.days.ago).where("strftime('%Y-%m-%dT%H:%M:00', created_at) != strftime('%Y-%m-%dT%H:%M:00', updated_at)").order(updated_at: :desc).limit(3)
                              #.shuffle.order('updated_at DESC')
  end
end
