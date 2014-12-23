ActiveAdmin.register AquaPost do
  permit_params :aqua_id, :body, :seo_title, :seo_description, :seo_keywords

  form do |f|
    f.inputs do
      f.input :aqua_id, :label => 'Aqua', :as => :select, :collection => Aqua.all.map{|a| ["#{a.name}", a.id]}
      f.input :body
      f.input :seo_title
      f.input :seo_description
      f.input :seo_keywords
      f.actions
    end
  end

  show do |aqua_post|
    attributes_table do
      row :aqua
      row :body
      row :seo_title
      row :seo_description
      row :seo_keywords
    end
    active_admin_comments
  end


end
