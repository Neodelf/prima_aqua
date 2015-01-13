ActiveAdmin.register Pomp do
  permit_params :title, :description, :image, :price, :seo_title, :seo_description, :seo_keywords

  form partial: 'admin/pomps/form.html.haml'

  show do |pomp|
    attributes_table do
      [:title, :description, :price, :seo_title, :seo_description, :seo_keywords].each do |attr|
        row attr.to_sym
      end
      row :image do
        image_tag pomp.image.url
      end
    end
    active_admin_comments
  end
end
