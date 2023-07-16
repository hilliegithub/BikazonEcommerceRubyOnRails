class AccountController < ApplicationController
  before_action :authenticate_account!

  def authenticate_account!
      redirect_to new_account_session_path unless account_signed_in? && (Account.find(params[:id].to_i) == current_account)
  end

  def show
    @account = Account.find(params[:id])
  end

  def edit
    @account = Account.find(params[:id])
    @error_message = params[:error_message]
  end

  def get_orders
    account = Account.find(params[:id])
    @orders = account.orders

    # @total = 0.0
    # @total = @order.order_items.each do |item|
    #   @total += item[:price] * item[:quantity]
    # end

    #@tax = ((@total * (@orders.pst + @orders.gst + @orders.hst)) / 100)
  end

  def update
    primarystreet = params['account']['primaryaddressstreet']
    primarypostalcode = params['account']['primarypostalcode']
    primaryprovince = params['account']['primary_province_id']
    secondarystreet = params['account']['secondaryaddressstreet']
    secondarypostalcode = params['account']['secondarypostalcode']
    secondaryprovince = params['account']['secondary_province_id']

    error_message_primary = 'You have to complete the corresponding primary address fields'
    error_message_secondary = 'You have to complete the corresponding secondary address fields'


    if primarystreet.present? && (primarypostalcode.blank? || primaryprovince.blank?)
        redirect_to account_edit_path(error_message: error_message_primary)
        return
      elsif (primarystreet.blank? || primaryprovince.blank?) && primarypostalcode.present?
        redirect_to account_edit_path(error_message: error_message_primary)
        return
      elsif primaryprovince.present? && (primarystreet.blank? || primarypostalcode.blank?)
        redirect_to account_edit_path(error_message: error_message_primary)
        return
    elsif secondarystreet.present? && (secondarypostalcode.blank? || secondaryprovince.blank?)
        redirect_to account_edit_path(error_message: error_message_secondary)
        return
    elsif (secondarystreet.blank? || secondaryprovince.blank?) && secondarypostalcode.present?
        redirect_to account_edit_path(error_message: error_message_secondary)
        return
    elsif secondaryprovince.present? && (secondarystreet.blank? || secondarypostalcode.blank?)
        redirect_to account_edit_path(error_message: error_message_secondary)
        return
    end

    account = Account.where(email: params['account']['email']).take
    if account.nil?
      redirect_to account_edit_path(error_message: 'Error in updating account information')
      return
    end

    if primarystreet.present?
      account.primaryaddressstreet= primarystreet
      account.primarypostalcode = primarypostalcode
      account.primary_province = Province.find(primaryprovince.to_i)
    end
    if secondarystreet.present?
      account.secondaryaddressstreet = secondarystreet
      account.secondarypostalcode = secondarypostalcode
      account.secondary_province = Province.find(secondaryprovince.to_i)
    end
    puts account.inspect
    account.save
    redirect_to account_edit_path(error_message: nil)
  end
end
