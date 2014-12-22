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
end
