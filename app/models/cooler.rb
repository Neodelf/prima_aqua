class Cooler < ActiveRecord::Base
  has_and_belongs_to_many :tags
  has_many :images, as: :imageable, dependent: :destroy

  def has_tag?(name)
    tags.where(name: name).any?
  end
end
