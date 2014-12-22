class AddNameToAquas < ActiveRecord::Migration
  def change
    add_column :aquas, :name, :string
  end
end
