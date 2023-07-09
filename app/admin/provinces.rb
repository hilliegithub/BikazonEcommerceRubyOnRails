ActiveAdmin.register Province do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :provincename, :taxtype, :pst, :gst, :hst
  #
  # or
  #
  # permit_params do
  #   permitted = [:provincename, :taxtype, :pst, :gst, :hst]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
