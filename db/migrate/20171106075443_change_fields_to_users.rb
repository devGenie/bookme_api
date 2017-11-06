class ChangeFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    change_column_null :users, :last_name, false, 1
    change_column_null :users, :email, false, 1
    change_column_null :users, :password, false, 1
    change_column_null :users, :date_added, false, 1
  end
end
