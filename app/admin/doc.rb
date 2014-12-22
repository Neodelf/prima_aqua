ActiveAdmin.register Doc do
  actions :index

  index do
    selectable_column
    column :id
    column :name do |doc|
      link_to "Cкачать #{doc.name.file.filename}", open_admin_doc_path(doc.id)
    end
    actions
  end

  member_action :open, method: :get do
    @doc = Doc.find(params[:id])
    send_file(@doc.name.path,
              :filename      =>  "#{@doc.name.file.filename}",
              :disposition => 'attachment',
              :url_based_filename => true)
  end

  controller do
    def destroy
      @doc = Doc.find(params[:id].to_i)
      aqua_id = @doc.aqua.id
      notice = @doc.destroy ? 'Image was successfully destroyed' : 'Image not destroyed'
      redirect_to edit_admin_aqua_path(aqua_id), notice: "#{notice}"
    end
  end
end
