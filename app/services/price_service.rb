class PriceService
  def self.get_price(aqua_id, volume_id, amount)
    price = Price.where(aqua_id: aqua_id, volume_id: volume_id).
                  where('start_count <= :count', count: amount).
                  order(:start_count).
                  last
    price.blank? ? 'По договоренности' : price.value.to_f * amount.to_i
  end
end
