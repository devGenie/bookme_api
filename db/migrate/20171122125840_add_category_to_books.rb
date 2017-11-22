class AddCategoryToBooks < ActiveRecord::Migration[5.1]
  def change
    add_reference :books, :category, foreign_key: true
    remove_column :books, :category
  end
end
