class AccountController < ApplicationController
  def show
    @account = Account.find(params[:id])
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    #puts params.inspect
    primarystreet = params["account"]["primaryaddressstreet"]
    primarypostalcode = params["account"]["primarypostalcode"]
    primaryprovince = params["account"]["primary_province_id"]
    secondarystreet = params["account"]["secondaryaddressstreet"]
    secondarypostalcode = params["account"]["secondarypostalcode"]
    secondaryprovince = params["account"]["secondary_province_id"]

    errorMessage = "You have to complete the corresponding address fields"

    if primarystreet.present? && (primarypostalcode.blank? || primaryprovince.blank?)
        flash[:error] = errorMessage
        puts "First"
        redirect_to account_edit_path
      elsif (primarystreet.blank? || primaryprovince.blank?) && primarypostalcode.present?
        flash[:error] = errorMessage
        puts "Second"
        redirect_to account_edit_path
      elsif primaryprovince.present? && (primarystreet.blank? || primarypostalcode.blank?)
        flash[:error] = errorMessage
        puts "Third"
        redirect_to account_edit_path
    elsif secondarystreet.present? && (secondarypostalcode.blank? || secondaryprovince.blank?)
        flash[:error] = errorMessage
        redirect_to account_edit_path
    elsif (secondarystreet.blank? || secondaryprovince.blank?) && secondarypostalcode.present?
        flash[:error] = errorMessage
        redirect_to account_edit_path
    elsif secondaryprovince.present? && (secondarystreet.blank? || secondarypostalcode.blank?)
        flash[:error] = errorMessage
        redirect_to account_edit_path
    end
  end
end
