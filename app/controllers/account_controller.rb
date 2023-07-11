class AccountController < ApplicationController
  def show
    @account = Account.find(params[:id])
  end

  def edit
    @account = Account.find(params[:id])
  end
end
