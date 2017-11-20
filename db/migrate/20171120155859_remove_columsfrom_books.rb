class RemoveColumsfromBooks < ActiveRecord::Migration[5.1]
  def change
    remove_columns :books, :date_added, :date_edited
    add_column :books, :title, :string, null:false, default:'Genie'
    add_column :books, :cover_image, :string
  end
end
