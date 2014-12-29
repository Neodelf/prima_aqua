class AddVolumeIdToPrice < ActiveRecord::Migration
  def change
    add_column :prices, :volume_id, :integer
  end
end
