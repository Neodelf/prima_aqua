class Accessory < ActiveRecord::Base
  mount_uploader :image, ImageUploader
end