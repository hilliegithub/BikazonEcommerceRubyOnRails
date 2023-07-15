class CheckoutController < ApplicationController
    # If they do, proceed to Stripe Payment
    #
    #
    #
    #

    def index
        # Check If the user is logged in.
        if account_signed_in?
            # If they are logged in, Check If they have an address on file
            @account = Account.find(current_account.id)
            puts @account.inspect
            if @account.primaryaddressstreet.present?
                address = @account.primaryaddressstreet
            elsif @account.secondaryaddressstreet.present?
                address = @account.secondaryaddressstreet
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
        # generate Stripe session and send customer
        session = Stripe::Checkout::Session.create({
            line_items: [{

              price_data: {
                currency: 'CAD',
                unit_amount: 1000,
                product_data: {
                    name: '___product_name',
                    description: 'Description',
                    #images: 'image_url,
                    metadata: {
                        account_id: '1',
                        product_id: '141'
                    }
                }
              },
              quantity: 1
            }],
            mode: 'payment',
            customer_email: 'test@email.com',#@account.email,
            success_url: 'https://b118-50-71-183-113.ngrok-free.app/success.html',
            cancel_url: 'https://b118-50-71-183-113.ngrok-free.app/cancel.html',
            # success_url: 'https://b118-50-71-183-113.ngrok-free.app/success.html',
            # cancel_url: 'https://b118-50-71-183-113.ngrok-free.app/cancel.html',
          })
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
        redirect_to checkout_path
    end

    def success

    end

    def cancel

    end


end
