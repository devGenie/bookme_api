class ChangeColumnBlacklistedonFromBlacklistedtokes < ActiveRecord::Migration[5.1]
  def change
    change_column :blacklisted_tokens, :blacklisted_on, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
  end
end