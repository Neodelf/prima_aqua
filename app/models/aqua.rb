class Aqua < ActiveRecord::Base
  has_many :aqua_posts
  has_many :docs
  has_many :prices
  has_many :volumes

  def to_params
    "#{id}-#{name}"
  end
end
