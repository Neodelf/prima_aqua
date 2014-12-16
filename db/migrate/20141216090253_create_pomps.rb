class CreatePomps < ActiveRecord::Migration
  def change
    create_table :pomps do |t|
      t.string :title
      t.text :description
      t.string :image
      t.integer :price
    end
  end
end
