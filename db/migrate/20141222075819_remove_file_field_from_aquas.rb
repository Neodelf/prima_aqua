class RemoveFileFieldFromAquas < ActiveRecord::Migration
  def change
    remove_column :aquas, :file
  end
end
