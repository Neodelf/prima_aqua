ActiveAdmin.register Price do
  permit_params :aqua_id, :value, :start_count, :end_count, :volume_id

  form do |f|
    f.inputs do
      f.input :aqua_id, label: 'Aqua', as: :select, collection: Aqua.all.map{|a| ["#{a.name}", a.id]}
      f.input :value
      f.input :volume_id, label: 'Volume', as: :select, collection: option_groups_from_collection_for_select(Aqua.all, :volumes, :name, :id, :value, @price.volume_id)
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
    column :volume do |price|
      price.volume.value
    end
    column :start_count
    column :end_count
    actions
  end

  show do |price|
    attributes_table do
      row :aqua
      row :value
      row :volume do
        link_to "#{price.volume.value}", admin_volume_path(price.volume.id)
      end
      row :start_count
      row :end_count
    end
    active_admin_comments
  end
end
