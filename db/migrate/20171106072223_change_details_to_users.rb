class ChangeDetailsToUsers < ActiveRecord::Migration[5.1]
  def change
    change_column_null :users, :first_name, false, 1
  end
end
