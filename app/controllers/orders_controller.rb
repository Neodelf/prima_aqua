class OrdersController < ApplicationController
  def create
    puts '---------------------------------------------------'
    puts params
    #{"info"=>{"customer_type"=>"individual", "name"=>"dsf safasdf sd", "phone"=>"f asdfsadf as", "address"=>"fas", "date"=>"16-04-2015", "time"=>"morning", "comment"=>"ва фыафыафыав", "empty_bottles"=>"on"}, "action"=>"create", "controller"=>"orders"}
    @order = Order.new
    @order.order_info = params['items']
    @order.customer_type = params['customer_type']
    @order.customer_name = params['name']
    @order.customer_phone = params['phone']
    @order.delivery_address = params['address']
    @order.delivery_date = Date.parse(params['date'])
    @order.delivery_time = params['time'] == 'morning' ? 'с 9 до 17' : 'с 17 до 22'
    @order.customer_comment = params['comment']
    @order.customer_deposit = (params['empty_bottles'] == 'on')
    @order.log = params.except(%w(action controller))
    json = OrderService.get_order_json(params['items'])
    if @order.save
      render
    else

    end
  end
end
