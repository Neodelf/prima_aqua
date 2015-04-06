class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.boolean :customer_deposit
      t.string :customer_type
      t.string :customer_name
      t.string :customer_phone
      t.string :delivery_address
      t.string :delivery_time
      t.date :delivery_date
      t.text :customer_comment
      t.text :order_info
      t.text :log
      t.float :cost

      t.timestamps
    end
  end
end
