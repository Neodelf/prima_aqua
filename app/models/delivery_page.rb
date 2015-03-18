class DeliveryPage < ActiveRecord::Base
  def to_param
    "#{id}-#{title}"
  end
  def has_water_line?
    water_line
  end
end
