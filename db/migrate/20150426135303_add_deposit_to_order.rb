class AddDepositToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :deposit, :float
  end
end
