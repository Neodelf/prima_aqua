class Aqua < ActiveRecord::Base
  mount_uploader :file, FileUploader
end