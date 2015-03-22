class AddedTimestamps < ActiveRecord::Migration
  def change
    [:accessories, :articles, :company_posts, :districts, :docs, :images,
     :phone_calls, :pomps, :prices, :products, :volumes].each do |table|
      add_column table, :created_at, :datetime
      add_column table, :updated_at, :datetime
    end
  end
end
