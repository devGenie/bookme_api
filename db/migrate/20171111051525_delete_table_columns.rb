class DeleteTableColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :created_at
  end
end
