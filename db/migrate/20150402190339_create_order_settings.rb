class CreateOrderSettings < ActiveRecord::Migration
  def change
    create_table :order_settings do |t|
      t.string :disabled_days
      t.string :disabled_weekdays
      t.string :disabled_morning_days
      t.string :disabled_morning_weekdays
      t.string :disabled_evening_days
      t.string :disabled_evening_weekdays

      t.timestamps
    end
  end
end
