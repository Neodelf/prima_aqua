class AquaPost < ActiveRecord::Base
  belongs_to :aqua
  mount_uploader :image, ImageUploader

  default_scope -> { order(position: :asc) }
end
