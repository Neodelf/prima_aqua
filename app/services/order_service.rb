class OrderService
  def self.get_price(aqua_id, volume_id, amount)
    price = Price.where(aqua_id: aqua_id, volume_id: volume_id).
                  where('start_count <= :count', count: amount).
                  order(:start_count).
                  last
    show_price(price.value, amount)
  end
  def self.show_price(price, amount)
    price.to_i < 1 ? 'Договорная' : (price.to_f * amount.to_f)
  end

  def self.check_date(date)
    dt = Date.parse(date)
    setting = OrderSetting.first
    result = []
    puts setting.disabled_day?(dt) || setting.disabled_date?(dt)
    puts setting.disabled_morning_day?(dt) || setting.disabled_morning_date?(dt)
    puts setting.disabled_evening_day?(dt) || setting.disabled_evening_date?(dt)
    if setting.disabled_day?(dt) || setting.disabled_date?(dt)
      result = [1,2]
    elsif setting.disabled_morning_day?(dt) || setting.disabled_morning_date?(dt)
      result << 1
    elsif setting.disabled_evening_day?(dt) || setting.disabled_evening_date?(dt)
      result << 2
    end
    result
  end
  #"aquas"=>{"0"=>{"aqua"=>"1-Prima Aqua", "volume"=>"5-19.0", "amount"=>"3", "price"=>"480"}}
  #"accessories"=>{"0"=>{"name"=>"Cooler 2", "amount"=>"2", "price"=>"123", "info"=>"2-Cooler", "step"=>"1"}, "1"=>{"name"=>"Cooler 2", "amount"=>"3", "price"=>"123", "info"=>"2-Cooler", "step"=>"1"}}
  def self.get_order_json(params)
    ar = []
    cost = 0
    params['items']['aquas'].each_pair do |_, aqua|
      name = Aqua.where(id: aqua['aqua']).pluck(:name).first
      volume = Volume.find(aqua['volume'])
      amount = aqua['amount'].to_i
      prc = amount*volume.value

      ar.push({ name: "#{name} #{volume.value}", amount: amount, cost: prc })
    end
    params['items']['accessories'].each_pair do |_, product|
      id, klass = product['info'].split('-')
      pr = klass.classify.constantize.find(id)
      amount = product['amount'].to_i
      ar.push({ name: pr.name, amount: amount, price: amount*pr.price })
    end
    {items: ar, }
  end
end
