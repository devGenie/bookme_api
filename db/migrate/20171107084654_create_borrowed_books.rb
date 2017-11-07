class CreateBorrowedBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :borrowed_books do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.datetime :date_borrowed, null:false, default:-> { 'CURRENT_TIMESTAMP' }
      t.datetime :date_due, null:false
      t.boolean :return_status, default:false 
      t.string :comments

      t.timestamps
    end
  end
end
