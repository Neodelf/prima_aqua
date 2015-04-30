class AddPositionToAquaPost < ActiveRecord::Migration
  def change
    add_column :aqua_posts, :position, :integer
  end
end
