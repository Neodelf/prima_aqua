ActiveAdmin.register CompanyPost do
  permit_params :title, :description, :image, :seo_title, :seo_keywords, :seo_description
  form partial: 'admin/company_posts/form'

  show do |company_post|
    attributes_table do
      row :title
      row :description
      row :image do
        image_tag company_post.image_url(:small)
      end
      row :seo_title
      row :seo_description
      row :seo_keywords
    end
    active_admin_comments
  end
end
