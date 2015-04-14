class AddBelongsToUserForOrder < ActiveRecord::Migration
  def change
    add_column :orders, :user_id, :integer, index: true
  end
end
