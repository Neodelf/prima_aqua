class CreateAquas < ActiveRecord::Migration
  def change
    create_table :aquas do |t|
      t.hstore :price
      t.string :short_description
      t.string :file
      t.timestamps
    end
  end
end
