class AddDeviseToUsers < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      t.string :name
      t.string :phone
      t.string :address
    end
  end

  def self.down
  end
end
