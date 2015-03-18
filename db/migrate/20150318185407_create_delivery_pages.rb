class CreateDeliveryPages < ActiveRecord::Migration
  def change
    create_table :delivery_pages do |t|
      t.string :title
      t.text :content
      t.boolean :water_line
      t.string :seo_title
      t.string :seo_keywords
      t.text :seo_description

      t.timestamps
    end
  end
end
