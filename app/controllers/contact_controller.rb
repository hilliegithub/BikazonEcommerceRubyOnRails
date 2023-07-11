class ContactController < ApplicationController
  def index
    @contact = Contact.first
  end
end
