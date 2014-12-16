class Aqua < ActiveRecord::Base
  mount_uploader :file, FileUploader
  has_many :aqua_posts
end
