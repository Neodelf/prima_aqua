class RemovePriceFromAqua < ActiveRecord::Migration
  def change
    remove_column :aquas, :price
  end
end
