class Product < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  scope :cups, -> { where(kind: 'cup')}
  scope :plates, -> { where(kind: 'plate')}
  scope :mixers, -> { where(kind: 'mixer')}
end
