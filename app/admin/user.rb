ActiveAdmin.register User do

  form partial: 'admin/users/form'

  controller do
    def permitted_params
      params['user']['customer_type'] = params['user']['customer_type'].to_i
      params.permit!
    end
  end

end
