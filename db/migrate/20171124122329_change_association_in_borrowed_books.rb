class ChangeAssociationInBorrowedBooks < ActiveRecord::Migration[5.1]
  def change
    add_reference :borrowed_books, :book_collection, foreign_key:true
    remove_column :borrowed_books, :book_id
  end
end