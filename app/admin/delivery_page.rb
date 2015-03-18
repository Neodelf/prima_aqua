ActiveAdmin.register DeliveryPage do
  form partial: 'admin/delivery_pages/form'

  controller do
    def permitted_params
      params.permit delivery_page: [:content, :title, :water_line, :seo_title, :seo_description, :seo_keywords]
    end
  end

end
