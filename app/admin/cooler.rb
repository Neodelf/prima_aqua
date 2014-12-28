ActiveAdmin.register Cooler do

  permit_params  :image, :title, :description, :price, :type_construction, :type_cooling, :heat, :power_heat, :cooling,
                 :power_cooling, :dimensions, :service, :seo_title, :seo_description, :seo_keywords, :tags
  form partial: 'admin/coolers/form.html.haml'

  show do |cooler|
    attributes_table do
      row :title
      row :description
      row :price
      row :type_construction
      row :type_cooling
      row :heat
      row :power_heat
      row :cooling
      row :power_cooling
      row :dimensions
      row :service
      row :seo_title
      row :seo_description
      row :seo_keywords
      row :image do
        image_tag cooler.image.url
      end
    end
    active_admin_comments
  end

  controller do
    def edit
      @cooler = Cooler.find(params[:id])
      @tags = @cooler.tags.pluck(:id).map{|id| id.to_s}
      gon.tags = @tags
    end

    def create
      @cooler = Cooler.new(permitted_params[:cooler])
      params[:cooler][:tags].map{|tag_id| @cooler.tags << Tag.find(tag_id) unless tag_id.blank? }

      respond_to do |format|
        if @cooler.save
          format.html { redirect_to admin_coolers_path, notice: 'Cooler was successfully created.' }
        else
          format.html { render action: 'new', notice: 'Cooler not created.' }
        end
      end
    end

    def update
      @cooler = Cooler.find(params[:id])
      @cooler.tags.delete_all
      params[:cooler][:tags].map{|tag_id| @cooler.tags << Tag.find(tag_id) unless tag_id.blank? }

      respond_to do |format|
        if @cooler.update_attributes(permitted_params[:cooler])
          format.html { redirect_to admin_coolers_path, notice: 'Cooler was successfully updates.' }
        else
          format.html { render action: 'new', notice: 'Cooler not updated.' }
        end
      end
    end
  end


end
