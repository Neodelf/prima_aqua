class Volume < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :aqua
  has_many :prices

  default_scope -> { order(value: :desc) }

  def value_str
    if value < 3.0
      :small
    elsif value > 10.0
      :big
    else
      :medium
    end
  end
end
