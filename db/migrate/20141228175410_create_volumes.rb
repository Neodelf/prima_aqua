class CreateVolumes < ActiveRecord::Migration
  def change
    create_table :volumes do |t|
      t.integer :value
      t.integer :aqua_id
      t.string :image
    end
  end
end
