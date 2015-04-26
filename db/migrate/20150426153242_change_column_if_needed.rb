class ChangeColumnIfNeeded < ActiveRecord::Migration
  def change
    if AquaPost.new.respond_to? :button_url
      rename_column :aqua_posts, :button_url, :hint
    end
  end
end
