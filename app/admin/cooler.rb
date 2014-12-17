ActiveAdmin.register Cooler do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params  :image, :title, :description, :price, :type_construction, :type_cooling, :heat, :power_heat, :cooling,
                 :power_cooling, :dimensions, :service
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end
