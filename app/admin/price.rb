ActiveAdmin.register Price do
  permit_params :aqua_id, :value, :start_count, :end_count

  form do |f|
    f.inputs do
      f.input :aqua_id, :label => 'Aqua', :as => :select, :collection => Aqua.all.map{|a| ["#{a.name}", a.id]}
      f.input :value
      f.input :start_count
      f.input :end_count
      f.actions
    end
  end

  index do
    selectable_column
    column :id
    column :aqua
    column :value
    column :start_count
    column :end_count
    actions
  end

  show do
    attributes_table do
      row :aqua
      row :value
      row :start_count
      row :end_count
    end
    active_admin_comments
  end
end
