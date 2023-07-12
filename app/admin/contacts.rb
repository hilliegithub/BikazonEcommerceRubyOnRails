ActiveAdmin.register Contact do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  actions :index, :show, :edit, :update

  permit_params :phonenumber, :email, :openinghours, :faq
  #
  # or
  #
  # permit_params do
  #   permitted = [:phonenumber, :email, :openinghours, :faq]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  controller do
    def new
      redirect_to admin_contacts_path
    end

    def create
      redirect_to admin_contacts_path
    end
  end

  form do |f|
    f.inputs do
      f.input :phonenumber
      f.input :email
      f.input :openinghours
      f.input :faq
    end
    f.actions
  end

end
