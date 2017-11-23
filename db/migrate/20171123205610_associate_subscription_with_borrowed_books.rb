class AssociateSubscriptionWithBorrowedBooks < ActiveRecord::Migration[5.1]
  def change
    add_reference :borrowed_books, :subscription, foreign_key: true
    remove_columns :borrowed_books, :user_id, :created_at, :updated_at
    add_column :borrowed_books, :date_returned, :datetime
  end
end