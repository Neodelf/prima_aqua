class CreateAccessories < ActiveRecord::Migration
  def change
    create_table :accessories do |t|
      t.string :title
      t.text :description
      t.string :image
      t.integer :price
    end
  end
end
