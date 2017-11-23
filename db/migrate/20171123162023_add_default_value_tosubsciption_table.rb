class AddDefaultValueTosubsciptionTable < ActiveRecord::Migration[5.1]
  def change
    change_column :subscriptions, :date_subscribed, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
    change_column_default :subscriptions, :subscription_status, true
    remove_columns :subscriptions, :created_at
    remove_columns :subscriptions, :updated_at
    remove_columns :subscriptions, :date_unsubscribed
  end
end
