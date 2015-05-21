class AddCategoryIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :category_id, :integer
    %w(cup plate mixer).each do |name|
      puts name
      Product.where(kind: name).each { |product| puts product.id; product.category = Category.where(name: name).first }
    end
    remove_column :products, :kind, :string
  end
end
