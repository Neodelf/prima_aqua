class Image < ActiveRecord::Base
  mount_uploader :name, ImageUploader
  belongs_to :imageable, polymorphic: true
end