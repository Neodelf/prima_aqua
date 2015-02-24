class AddLonAndLatToDistrict < ActiveRecord::Migration
  def change
    add_column :districts, :lat, :float
    add_column :districts, :lon, :float
  end
end
