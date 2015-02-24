ActiveAdmin.register District do
  permit_params :name, :popup, :str
  form do |f|
    f.semantic_errors
    [:name, :str].each do |param|
      inputs "#{param.capitalize}" do
        input param, label: false
      end
    end
    inputs 'Popup' do
      input :popup, as: :ckeditor, label: false
    end
    actions
  end
end
