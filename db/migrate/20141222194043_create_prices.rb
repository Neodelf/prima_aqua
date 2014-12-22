class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.integer :value
      t.integer :start_count
      t.integer :end_count
      t.belongs_to :aqua
    end
  end
end
