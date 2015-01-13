ActiveAdmin.register Accessory do
  form partial: 'admin/accessories/form'
  show do |accessory|
    attributes_table do
      row :title
      row :description
      row :price
      row :image do
        image_tag(accessory.image)
      end
    end
    active_admin_comments
  end
  permit_params :title, :description, :image, :price, :seo_title, :seo_description, :seo_keywords
end
