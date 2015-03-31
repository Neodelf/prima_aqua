class PriceService
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
end
