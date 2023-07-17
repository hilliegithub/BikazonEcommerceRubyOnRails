ActiveAdmin.register Order do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :shippingAddress, :paymentmethod, :status, :pst, :gst, :hst, :account_id, :new, :edit

  controller do
    def new
      redirect_to admin_order_path
    end
    # def edit
    #   redirect_to admin_order_path
    # end
  end

  show do |order|
    attributes_table do
      row :id
      row :shippingAddress
      row :paymentmethod
      row :status
      row  'PST' do |orderr|
        number_to_percentage(orderr.pst, precision: 2)
      end
      row  'GST' do |orderr|
        number_to_percentage(orderr.gst, precision: 2)
      end
      row  'HST' do |orderr|
        number_to_percentage(orderr.hst, precision: 2)
      end
      row 'Account' do |orderrow|
        link_to orderrow.account.email, admin_account_path(orderrow.account)
      end
      row 'Tax' do |orderrow|
        number_to_currency(((orderrow.order_items.all.reduce(0) { |sum, item| sum + item.price * item.quantity }) * (orderrow.pst + orderrow.gst + orderrow.hst))/100)
      end
      row 'Grand Total' do |orderrow|
        number_to_currency((((orderrow.order_items.all.reduce(0) { |sum, item| sum + item.price * item.quantity }) * (orderrow.pst + orderrow.gst + orderrow.hst))/100) + orderrow.order_items.all.reduce(0) { |sum, item| sum + item.price * item.quantity })
      end

      panel 'Items Ordered' do
        table_for order.order_items do
          column  'Product' do |orderitem|
              link_to orderitem.product.productname, admin_product_path(orderitem.product)
            end
          column 'Unit Price' do |orderitem|
            number_to_currency(orderitem.price)
          end
          column 'Quantity' do |orderitem|
            orderitem.quantity
          end

        end # End of order_items Table
      end
    end
  end

  form do |f|
    f.inputs "Order Status" do
      f.input :status
      f.input :id, as: :number, input_html: { disabled: true, value: f.object.id}
      f.input 'Payment Method', as: :string, input_html: { disabled: true, value: f.object.paymentmethod}
      f.input :account, as: :string, input_html: { disabled: true, value: f.object.account.email}
      f.input 'Shipping Address', as: :string, input_html: { disabled: true, value: f.object.shippingAddress}
      #f.input 'Order Total', as: :number, input_html: { disabled: true, value: }
    end
    f.actions
  end


end
