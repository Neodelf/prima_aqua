ActiveAdmin.register Cooler do

  permit_params  :image, :title, :description, :price, :type_construction, :type_cooling, :heat, :power_heat, :cooling,
                 :power_cooling, :dimensions, :service, :seo_title, :seo_description, :seo_keywords, :tags
  form partial: 'admin/coolers/form.html.haml'

  index do
    selectable_column
    column :id
    column :title
    column :description
    column :price
    column :type_construction
    column :type_cooling
    column :heat
    column :power_heat
    column :cooling
    column :power_cooling
    column :dimensions
    column :service
    column :seo_title
    column :seo_description
    column :seo_keywords
    column :image
    column :tags do |cooler|
      ul do
        cooler.tags.each do |tag|
          li do
            "#{tag.name}"
          end
        end
      end
    end
    column :seo_title
    column :seo_description
    column :seo_keywords
    actions
  end

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
        image_tag cooler.images.first.name.url if cooler.images.first.present?
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
      @cooler.images.build(params[:image][:name].map{|str| {name: str} }) if params[:image].present?

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
      if params[:cooler][:tags].present?
        @cooler.tags.delete_all
        params[:cooler][:tags].map{|tag_id| @cooler.tags << Tag.find(tag_id) unless tag_id.blank? }
      end

      if params[:image].present? && params[:image][:name].present?
        @cooler.images.delete_all
        @cooler.images.build(params[:image][:name].map{|str| {name: str} })
      end

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
