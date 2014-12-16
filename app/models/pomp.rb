class Pomp < ActiveRecord::Base
  mount_uploader :image, ImageUploader
end
