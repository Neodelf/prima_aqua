class AddSeoFields < ActiveRecord::Migration
  def change
    [:accessories, :aquas, :aqua_posts, :articles, :company_posts, :coolers,
     :districts, :pomps, :products, :tags].each do |table|
      add_column table, :seo_title, :string
      add_column table, :seo_description, :string
      add_column table, :seo_keywords, :string
    end
  end
end
