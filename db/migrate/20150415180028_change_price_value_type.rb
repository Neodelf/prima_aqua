class ChangePriceValueType < ActiveRecord::Migration
  def up
    change_column :prices, :value, :float
  end
  def down; end
end
