class CreateCompanyPosts < ActiveRecord::Migration
  def change
    create_table :company_posts do |t|
      t.string :title
      t.text :description
      t.string :background_color
    end
  end
end
