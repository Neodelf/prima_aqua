class CreateAquas < ActiveRecord::Migration
  def change
    create_table :aquas do |t|
      t.hstore :price
      t.string :short_description
      t.string :file
    end
  end
end
