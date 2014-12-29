ActiveAdmin.register Volume do

  permit_params :value, :aqua_id, :image

  form partial: 'admin/volumes/form'

  index do
    selectable_column
    column :id
    column :aqua
    column :value
    column :image
    actions
  end

  show do |volume|
    attributes_table do
      row :aqua
      row :value
      row :image do
        image_tag volume.image
      end
    end
    active_admin_comments
  end

end
