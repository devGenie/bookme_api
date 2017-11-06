class ChangeDefaultDateForUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :date_added, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
