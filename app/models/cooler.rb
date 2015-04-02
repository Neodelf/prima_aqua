class Cooler < ActiveRecord::Base
  has_and_belongs_to_many :tags
  mount_uploader :image, ImageUploader

  def has_tag?(name)
    tags.where(name: name).any?
  end
end
