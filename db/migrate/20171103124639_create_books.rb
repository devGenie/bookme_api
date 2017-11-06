class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :isbn
      t.integer :copies
      t.text :description
      t.references :author, foreign_key: true
      t.integer :cover_type
      t.integer :category
      t.datetime :date_added
      t.datetime :date_edited

      t.timestamps
    end
  end
end
