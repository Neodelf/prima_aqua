class AddKindToProducts < ActiveRecord::Migration
  def change
    add_column :products, :kind, :string
    add_index :products, :kind
  end
end
