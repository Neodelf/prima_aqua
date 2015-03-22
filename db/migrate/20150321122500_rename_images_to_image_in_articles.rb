class RenameImagesToImageInArticles < ActiveRecord::Migration
  def change
    rename_column :articles, :images, :image
  end
end
