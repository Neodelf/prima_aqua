class AddFieldsForTags < ActiveRecord::Migration
  def change
    add_column :tags, :main, :boolean, default: false
    Tag.reset_column_information
    Tag.includes(:coolers).limit(4).update_all(main: true)
  end
end
