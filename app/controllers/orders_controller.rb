class OrdersController < ApplicationController
  def create
    @order = Order.new
    if current_user
      @order.user = current_user
    elsif params['info']['register_flag'] == 'true'
      @order.user = if user = User.find_by(email: params[:email])
                      user
                    else
                      user = User.new(email: params[:email])
                      user.password = params[:password]
                      if user.valid?
                        user.save
                        user
                      else
                        nil
                      end
                    end
    end
    @order.order_info = params['items'].to_s
    @order.customer_type = params['info']['customer_type']
    @order.customer_name = params['info']['name']
    @order.customer_phone = params['info']['phone']
    @order.delivery_address = params['info']['address']
    @order.delivery_date = Date.parse(params['info']['date'])
    @order.delivery_time = params['info']['time'] == 'morning' ? 'с 9 до 17' : 'с 17 до 22'
    @order.customer_comment = params['info']['comment']
    @order.customer_deposit = (params['info']['empty_bottles'] == 'true')
    @order.deposit = params['info']['deposit']
    @order.log = params.except(%w(action controller)).to_s
    json = OrderService.get_order_json(params['items'])
    if @order.save
      json.merge!(deposit: params['info']['deposit']) if @order.customer_deposit
      render json: json, status: :ok
    else
      render json: json, status: 500
    end
  end
end
