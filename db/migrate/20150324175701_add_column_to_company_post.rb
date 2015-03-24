class AddColumnToCompanyPost < ActiveRecord::Migration
  def change
    add_column :company_posts, :image, :string
    remove_column :company_posts, :background_color
  end
end
