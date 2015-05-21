class CreateCategory < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :slug
    end
    {cup: 'Стаканчики', plate: 'Тарелки', mixer: 'Мешалки'}.each do |key, value|
      Category.create(slug: key, name: value)
    end
  end
end
