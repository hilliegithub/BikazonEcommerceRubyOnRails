class CheckoutController < ApplicationController
    # If they do, proceed to Stripe Payment
    #
    #
    #
    #

    def index
        # If cart is empty just return
        if @cart.length == 0
            redirect_to cart_path
        end
        # Check If the user is logged in.
        if account_signed_in?
            # If they are logged in, Check If they have an address on file
            @account = Account.find(current_account.id)
            puts @account.inspect
            if @account.primaryaddressstreet.present?
                address = @account.primaryaddressstreet
                postalcode = @account.primarypostalcode
                province = @account.primary_province_id#Province.find(@account.primary_province_id).provincename
            elsif @account.secondaryaddressstreet.present?
                address = @account.secondaryaddressstreet
                postalcode = @account.secondarypostalcode
                province = @account.secondary_province_id#Province.find(@account.secondary_province_id).provincename
            else
                address = nil
            end

            # If they Don't have an address, let them enter the Address, then proceed
            if address == nil
                #redirect_to checkout_address_path
                render :address
                return
            # else
            #     # If they have an address and are sign in, send to stripe action
            #     redirect_to checkout_stripe_path
            end
        else
            # If the user is not logged in, Ask for the address and proceed to Check out
            if session[:addressstreet].blank?
                #redirect_to checkout_address_path
                render :address
                return
                # else
                #     # No logged in user but has entered address send to stripe action
                #     redirect_to checkout_stripe_path
            end
        end

        if !account_signed_in?
            address = session[:addressstreet]
            postalcode = session[:postalcode]
            province = session[:province_id]#Province.find(session[:province_id]).provincename
        end

        # Setup details to charge customer for
        currency = 'CAD'
        data = @cart.map { |cartitem|
            product = Product.find(cartitem['id'])
            purchaseitem = {
                currency: currency,
                unit_amount: (product.price * 100).to_i,
                name: product.productname,
                description: product.description,
                quantity: cartitem['qty'],
                id: cartitem['id']
            }
        }

        total_tax = data.reduce(0) do |sum, item|
            sum + item[:unit_amount] * item[:quantity]
        end
        #puts total_sum
        p = Province.find(province)
        tax = {
            currency: currency,
            unit_amount: ((total_tax * (p.pst + p.gst + p.hst))/100).to_i,
            name: p.provincename + ' Tax',
            description: p.taxtype,
            quantity: 1,
            id: 0
        }
        data << tax

        puts data
        console
        #debugger
        #generate Stripe session and send customer
        session = Stripe::Checkout::Session.create({
            line_items: [
                data.map do |d|
                    {
                    price_data: {
                        currency: d[:currency],
                        unit_amount: d[:unit_amount],
                        product_data: {
                            name: d[:name],
                            description: d[:description],
                            #images: 'image_url,
                            metadata: {
                                product_id: d[:id]
                                }
                            }
                        },
                    quantity: d[:quantity]
                    }

                end
        ],
            mode: 'payment',
            success_url: "#{ENV['NGROK']}/success?session_id={CHECKOUT_SESSION_ID}",
            cancel_url: "#{ENV['NGROK']}/cancel.html",
            metadata: {
                address: address,
                postalcode: postalcode,
                province: Province.find(province).provincename,
                cart: @cart.to_json,
                account_id: account_signed_in? ? current_account.id.to_s : 'N/A',
            },
            customer_email: account_signed_in? ? @account.email : nil
          })
         puts session.inspect
         #debugger
         redirect_to session.url, allow_other_host: true, status: 303
    end

    def address_update
        puts params
        if account_signed_in?
            account = Account.find(current_account.id)
            account.primaryaddressstreet = params["addressstreet"]
            account.primarypostalcode = params["postalcode"]
            account.primary_province_id = params["primary_province_id"]
            puts account.inspect
            account.save
        else
            session[:addressstreet] ||= params["addressstreet"]
            session[:postalcode] ||= params["postalcode"]
            session[:province_id] ||= params["primary_province_id"]
        end
        redirect_to cart_path
    end

    def success
        if !params[:session_id].nil?
            session = Stripe::Checkout::Session.retrieve(params[:session_id])
            payment_intent = Stripe::PaymentIntent.retrieve(session["payment_intent"])
            charge = Stripe::Charge.retrieve(payment_intent['latest_charge'])
            puts session.inspect

            @purchased = JSON.parse(session["metadata"]["cart"])
            @total = session["amount_total"].to_d
            @buyer = {
                address: session[:metadata][:address],
                postalcode: session[:metadata][:postalcode],
                province: session[:metadata][:province],
                invoice_url: charge['receipt_url'],
                email: session[:metadata][:account_id] == "N/A" ? session[:customer_details][:email] : Account.find(session[:metadata][:account_id].to_i).email
            }
            puts @buyer.inspect
            province = Province.where(provincename: session[:metadata][:province]).take
            #Create an Order Record
            order = Order.new(
                paymentmethod: session[:payment_method_types][0],
                shippingAddress: session[:metadata][:address] + ' ' + session[:metadata][:postalcode] + ' ' + session[:metadata][:province],
                status: 'paid',
                pst: province.pst,
                gst: province.gst,
                hst: province.hst,
                stripe_session: session[:id],
                account_id: session[:metadata][:account_id] == 'N/A' ? nil : Account.find(session[:metadata][:account_id].to_i).id
            )
            puts order.inspect
            @oorder = order
            order.save

            # Update the products table with amount in stock
            @oorderitem = []
            @purchased.each do |item|
                prod = Product.find(item['id'])
                prod.amountinstock = prod.amountinstock - 2

                # Create OrderItems For each item
                orderitem = OrderItem.new(
                    price: prod.price,
                    quantity: item['qty'],#.to_i
                    order_id: order.id,
                    product_id: prod.id
                    )
                puts orderitem.inspect
                @oorderitem << orderitem
                orderitem.save
                prod.save
            end

            # Expire the stripe checkout session
        end
    end

    def cancel

        # Expire the stripe checkout session
    end


end
