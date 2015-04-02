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
end
