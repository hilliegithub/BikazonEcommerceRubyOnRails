ActiveAdmin.register About do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  actions :index, :show, :edit, :update

  permit_params :title, :body

  controller do
    def new
      redirect_to admin_abouts_path
    end

    def create
      redirect_to admin_abouts_path
    end
  end

  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :body]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  form do |f|
    f.inputs do
      f.input :title
      f.input :body, as: :text
    end
    f.actions
  end

end
