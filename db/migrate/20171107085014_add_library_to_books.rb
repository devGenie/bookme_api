class AddLibraryToBooks < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :books, :libraries
  end
end
