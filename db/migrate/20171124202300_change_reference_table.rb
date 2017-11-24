class ChangeReferenceTable < ActiveRecord::Migration[5.1]
  def change
    add_reference :book_collections, :book, foreign_key:true
    remove_column :book_collections, :books_id
  end
end
