class OrdersController < ApplicationController
  def create
    @order = Order.new
    @order.user = current_user if current_user
    @order.order_info = params['items'].to_s
    @order.customer_type = params['info']['customer_type']
    @order.customer_name = params['info']['name']
    @order.customer_phone = params['info']['phone']
    @order.delivery_address = params['info']['address']
    @order.delivery_date = Date.parse(params['info']['date'])
    @order.delivery_time = params['info']['time'] == 'morning' ? 'с 9 до 17' : 'с 17 до 22'
    @order.customer_comment = params['info']['comment']
    @order.customer_deposit = (params['info']['empty_bottles'] == 'on')
    @order.log = params.except(%w(action controller)).to_s
    json = OrderService.get_order_json(params['items'])
    if @order.save
      render json: json, status: :ok
    else
      render json: json, status: 500
    end
  end
end
