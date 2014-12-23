class Aqua < ActiveRecord::Base
  has_many :aqua_posts
  has_many :docs
  has_many :prices
end
