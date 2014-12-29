class Volume < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :aqua
end