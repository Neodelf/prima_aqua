class AquaPost < ActiveRecord::Base
  belongs_to :aqua
  mount_uploader :image, ImageUploader
end
