# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :small do
    process resize_to_limit: [200, 200]
  end

  version :background, :if => :is_aqua_post? do
    process resize_to_fill: [1366, 768]
    process quality: 60
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  private

  def is_volume? picture
    model.is_a? Volume
  end

  def is_aqua_post? picture
    model.is_a? AquaPost
  end

end
