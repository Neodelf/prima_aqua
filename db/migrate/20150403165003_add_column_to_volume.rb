class AddColumnToVolume < ActiveRecord::Migration
  def change
    add_column :volumes, :deposit, :float
  end
end
