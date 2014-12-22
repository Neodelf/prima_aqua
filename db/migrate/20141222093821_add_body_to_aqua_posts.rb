class AddBodyToAquaPosts < ActiveRecord::Migration
  def change
    add_column :aqua_posts, :body, :text
  end
end
