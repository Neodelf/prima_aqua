class Doc < ActiveRecord::Base
  mount_uploader :name, FileUploader
  belongs_to :aqua
end
