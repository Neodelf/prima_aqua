ActiveAdmin.register Product do
  form partial: 'admin/products/form'
  show do |product|
    attributes_table do
      row :title
      row :price
      row :seo_title
      row :seo_description
      row :seo_keywords
      row :image do
        image_tag(product.image.url(:small))
      end
      row :kind
    end
    active_admin_comments
  end
  permit_params :title, :image, :price, :seo_title, :seo_description, :seo_keywords, :kind
end
