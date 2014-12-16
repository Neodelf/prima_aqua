class Article < ActiveRecord::Base
  mount_uploader :images, ImageUploader
end