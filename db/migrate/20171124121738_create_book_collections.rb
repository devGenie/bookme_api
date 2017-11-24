class CreateBookCollections < ActiveRecord::Migration[5.1]
  def change
    create_table :book_collections do |t|
      t.references :books, foreign_key:true
      t.boolean :availability_status, null:false, default:true
      t.timestamps
    end
  end
end
