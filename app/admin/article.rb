ActiveAdmin.register Article do

  form partial: 'admin/articles/form'
  permit_params :title, :description, :type, :grow_descript, :image, :seo_title, :seo_description, :seo_keywords

end
