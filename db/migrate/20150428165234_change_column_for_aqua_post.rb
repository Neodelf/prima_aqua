class ChangeColumnForAquaPost < ActiveRecord::Migration
  def change
    change_column :aqua_posts, :hint, :text
  end
end
