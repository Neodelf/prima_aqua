class AddColumnsToAquaPosts < ActiveRecord::Migration
  def change
    add_column :aqua_posts, :title, :string
    add_column :aqua_posts, :button_name, :string
    add_column :aqua_posts, :button_url, :string
    add_column :aqua_posts, :link_name, :string
    add_column :aqua_posts, :link_url, :string
    add_column :aqua_posts, :image, :string
    add_column :aqua_posts, :text_color, :string
  end
end
