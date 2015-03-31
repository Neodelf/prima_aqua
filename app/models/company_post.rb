class CompanyPost < ActiveRecord::Base
  mount_uploader :image, ImageUploader
end
