class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.string :type
      t.text :grow_descript
      t.string :images
    end
  end
end
