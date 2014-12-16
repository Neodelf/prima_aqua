class CreatePhoneCall < ActiveRecord::Migration
  def change
    create_table :phone_calls do |t|
      t.string :name
      t.string :phone
      t.string :time
    end
  end
end
