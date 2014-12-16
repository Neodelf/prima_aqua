class CreateCoolersAndTags < ActiveRecord::Migration
  def change
    create_table :coolers do |t|
      t.string :image
      t.string :title
      t.text :description
      t.integer :price
      t.string :type_construction
      t.string :type_cooling
      t.string :heat
      t.integer :power_heat
      t.string :cooling
      t.integer :power_cooling
      t.string :dimensions
      t.text :service

      t.timestamps
    end

    create_table :tags do |t|
      t.string :name

      t.timestamps
    end

    create_table :coolers_tags, id: false do |t|
      t.belongs_to :cooler, index: true
      t.belongs_to :tag, index: true
    end
  end
end
