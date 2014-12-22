ActiveAdmin.register Aqua do
  form partial: 'admin/aquas/form'

  index do
    selectable_column
    column :id
    column :price do |aqua|
      ul do
        aqua.prices.each do |price|
          li do
            "#{price.value} руб. за объем от #{price.start_count}шт. до #{price.end_count}шт."
          end
        end
      end
    end
    column :short_description
    column 'Docs' do |aqua|
      ul do
        aqua.docs.each do |doc|
          li do
            link_to "Cкачать #{doc.name.file.filename}", open_admin_doc_path(doc.id)
          end
        end
      end
    end
    column :seo_title
    column :seo_description
    column :seo_keywords
    actions
  end

  show do |aqua|
    attributes_table do
      row :price do
        ul do
          aqua.prices.each do |price|
            li do
              "#{price.value} руб. за объем от #{price.start_count}шт. до #{price.end_count}шт."
            end
          end
        end
      end
      row :short_description
      row :doc do
        ul do
          aqua.docs.each do |doc|
            li do
              link_to "Cкачать #{doc.name.file.filename}", open_admin_doc_path(doc.id)
            end
          end
        end
      end
    end
    active_admin_comments
  end

  member_action :destroy_all_docs, method: :delete do
    @aqua = Aqua.find(params[:id])
    @aqua.docs.delete_all
    redirect_to edit_admin_aqua_path(@aqua.id), notice: 'All docs was successfully destroyed'
  end

  controller do
    def aqua_params
      params.require(:aqua).permit(:short_description, :seo_title, :seo_description, :seo_keywords)
    end

    def create
      @aqua = Aqua.new(aqua_params)
      @aqua.docs.build(params[:doc][:name].map{|str| {name: str} }) if params[:doc].present?

      respond_to do |format|
        if @aqua.save
          format.html { redirect_to admin_aquas_path, notice: 'Aqua was successfully created.' }
        else
          format.html { render action: 'new', notice: 'Aqua not created.' }
        end
      end
    end

    def update
      @aqua = Aqua.find(params[:id])
      @aqua.docs.build(params[:doc][:name].map{|str| {name: str} }) if params[:doc].present?

      respond_to do |format|
        if @aqua.update_attributes(aqua_params)
          format.html { redirect_to admin_aquas_path, notice: 'Aqua was successfully updates.' }
        else
          format.html { render action: 'new', notice: 'Aqua not updated.' }
        end
      end
    end

    def destroy
      aqua = Aqua.find(params[:id])
      aqua.destroy
      redirect_to admin_aquas_path
    end
  end
end
