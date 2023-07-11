ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :productname, :price, :amountinstock, :category_id, :description, images: []
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
    column  "Images" do |product|
      product.images.each do |image|
        span do
          image_tag(image.variant(resize_to_limit: [100,100]))
        end
      end
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :productname
      row :price
      row :amountinstock
      row "Category" do |product|
        product.category.categoryname
      end
      row :description
      row "Images" do |product|
        product.images.each do |image|
          span do
            image_tag(image.variant(resize_to_limit: [300,300]))
          end
        end
      end
    end
  end

  form do |f|
    f.inputs "Product Details" do
      f.input :productname
      f.input :price
      f.input :amountinstock
      f.input :category, collection: Category.all.map { |c| [c.categoryname, c.id] }
      f.input :description
      f.input :images, as: :file, input_html: { multiple: true }
    end
    f.actions
  end

end
