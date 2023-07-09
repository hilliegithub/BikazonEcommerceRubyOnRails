# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "csv"

Product.destroy_all
Category.destroy_all
Province.destroy_all

csv_file = Rails.root.join('db/book1.csv')
csv_data = File.read(csv_file)

csv = CSV.parse(csv_data, headers: true)

bProvince = [
    {:pname => 'Alberta', :type => 'GST', :pst => 0.0, :gst => 5.0, :hst => 0.0},
    {:pname => 'British Colombia', :type => 'GST+PST', :pst => 7.0, :gst => 5.0, :hst => 0.0},
    {:pname => 'Manitoba', :type => 'GST+PST', :pst => 7.0, :gst => 5.0, :hst => 0.0},
    {:pname => 'New Brunswick', :type => 'HST', :pst => 0.0, :gst => 0.0, :hst => 15.0},
    {:pname => 'Newfoundland and Labrador', :type => 'HST', :pst => 0.0, :gst => 0.0, :hst => 15.0},
    {:pname => 'Nova Scotia', :type => 'HST', :pst => 0.0, :gst => 0.0, :hst => 15.0},
    {:pname => 'Prince Edward Island', :type => 'HST', :pst => 0.0, :gst => 0.0, :hst => 15.0},
    {:pname => 'Northwest Territories', :type => 'GST', :pst => 0.0, :gst => 5.0, :hst => 0.0},
    {:pname => 'Nunavut', :type => 'GST', :pst => 0.0, :gst => 5.0, :hst => 0.0},
    {:pname => 'Ontario', :type => 'HST', :pst => 0.0, :gst => 0.0, :hst => 13.0},
    {:pname => 'Quebec', :type => 'GST+QST', :pst => 9.975, :gst => 5.0, :hst => 0.0},
    {:pname => 'Saskatchewan', :type => 'GST+PST', :pst => 6.0, :gst => 5.0, :hst => 0.0},
    {:pname => 'Yukon', :type => 'GST', :pst => 0.0, :gst => 5.0, :hst => 0.0}
]

bProvince.each do |province|
    prov = Province.new(
        provincename: province[:pname],
        taxtype: province[:type],
        pst: province[:pst],
        gst: province[:gst],
        hst: province[:hst],
    )
    puts prov.inspect
    prov.save
    prov.errors.messages.each do |column, errors|
        errors.each do |error|
          puts "The #{column} property #{error}."
        end
      end
end

bCategories = ["Helmets", "Tires", "Air Filter", "Oil Filter", "Brakes", "Exhausts", "Security"]

bCategories.each do |category|
    Category.create(categoryname: category)
end

csv.each do |product|
    category = Category.find_by(categoryname: product["category"])
    #puts product["productname"]
    #puts product["price"]
    #puts product["amount"]
    prod = Product.create(
        productname: product["productname"],
        price: product["price"],
        description: product["description"],
        amountinstock: product["amount"],
        category: category
    )
    #puts prod.inspect
    prod.errors.messages.each do |column, errors|
        errors.each do |error|
          puts "The #{column} property #{error}."
        end
      end
end

if AdminUser.count < 1
    AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
end