class AccountController < ApplicationController
  def show
    @account = Account.find(params[:id])
  end

  def edit
    @account = Account.find(params[:id])
    puts params.inspect
    @error_message = params[:error_message]
  end

  def update
    primarystreet = params["account"]["primaryaddressstreet"]
    primarypostalcode = params["account"]["primarypostalcode"]
    primaryprovince = params["account"]["primary_province_id"]
    secondarystreet = params["account"]["secondaryaddressstreet"]
    secondarypostalcode = params["account"]["secondarypostalcode"]
    secondaryprovince = params["account"]["secondary_province_id"]

    errorMessageP = "You have to complete the corresponding primary address fields"
    errorMessageS = "You have to complete the corresponding secondary address fields"
    #puts params["account"]
    #puts primarystreet.present?
    if primarystreet.present? && (primarypostalcode.blank? || primaryprovince.blank?)
        redirect_to account_edit_path(error_message: errorMessageP)
        return
      elsif (primarystreet.blank? || primaryprovince.blank?) && primarypostalcode.present?
        redirect_to account_edit_path(error_message: errorMessageP)
        return
      elsif primaryprovince.present? && (primarystreet.blank? || primarypostalcode.blank?)
        redirect_to account_edit_path(error_message: errorMessageP)
        return
    elsif secondarystreet.present? && (secondarypostalcode.blank? || secondaryprovince.blank?)
        redirect_to account_edit_path(error_message: errorMessageS)
        return
    elsif (secondarystreet.blank? || secondaryprovince.blank?) && secondarypostalcode.present?
        redirect_to account_edit_path(error_message: errorMessageS)
        return
    elsif secondaryprovince.present? && (secondarystreet.blank? || secondarypostalcode.blank?)
        redirect_to account_edit_path(error_message: errorMessageS)
        return
    end

    account = Account.where(email: params["account"]["email"]).take
    if account == nil
      redirect_to account_edit_path(error_message: "Error in updating account information")
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
