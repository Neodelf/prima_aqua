class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :customer_type, :integer
  end
end
