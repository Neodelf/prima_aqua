class CreateAquaPosts < ActiveRecord::Migration
  def change
    create_table :aqua_posts do |t|
      t.belongs_to :aqua
      t.timestamps
    end
  end
end
