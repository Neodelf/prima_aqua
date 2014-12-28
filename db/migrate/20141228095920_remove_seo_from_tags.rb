class RemoveSeoFromTags < ActiveRecord::Migration
  def change
    remove_column :tags, :seo_title
    remove_column :tags, :seo_description
    remove_column :tags, :seo_keywords
  end
end
