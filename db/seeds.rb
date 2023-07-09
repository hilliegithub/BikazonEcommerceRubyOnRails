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

csv_file = Rails.root.join('db/book1.csv')
csv_data = File.read(csv_file)

csv = CSV.parse(csv_data, headers: true)


bCategories = ["Helmets", "Tires", "Air Filter", "Oil Filter", "Brakes", "Exhausts", "Security"]

bCategories.each do |category|
    Category.create(categoryname: category)
end

csv.each do |product|
    category = Category.find_by(categoryname: product["category"])
    puts product["productname"]
    puts product["price"]
    puts product["amount"]
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