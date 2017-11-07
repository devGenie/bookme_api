class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.references :user, foreign_key: true, null:false
      t.references :library, foreign_key: true, null:false
      t.datetime :date_subscribed, null:false
      t.datetime :date_unsubscribed
      t.boolean :subscription_status, null:false, default: false

      t.timestamps
    end
  end
end
