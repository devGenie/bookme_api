class AddDefaultValueTosubsciptionsTable < ActiveRecord::Migration[5.1]
  def change
    change_column :subscriptions, :created_at, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
    change_column :subscriptions, :updated_at, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
