class CreateDistrict < ActiveRecord::Migration
  def change
    create_table :districts do |t|
      t.string :name
      t.string :popup
      t.boolean :str
    end
  end
end
