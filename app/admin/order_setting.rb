ActiveAdmin.register OrderSetting do
  permit_params :disabled_days,
               :disabled_weekdays,
               :disabled_morning_days,
               :disabled_morning_weekdays,
               :disabled_evening_days,
               :disabled_evening_weekdays

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end
