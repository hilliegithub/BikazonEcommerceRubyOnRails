ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :productname, :price, :amountinstock, :category_id, :description
  #
  # or
  #
  # permit_params do
  #   permitted = [:productname, :price, :amountinstock, :category_id, :description]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index do
    selectable_column
    id_column
    column :productname
    column :price
    column :amountinstock
    column "Category" do |product|
      product.category.categoryname
    end
    column :description
    actions
  end

  form do |f|
    f.inputs "Product Details" do
      f.input :productname
      f.input :price
      f.input :amountinstock
      f.input :category, collection: Category.all.map { |c| [c.categoryname, c.id] }
      f.input :description
    end
    f.actions
  end

end
