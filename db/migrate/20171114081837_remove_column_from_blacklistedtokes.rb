class RemoveColumnFromBlacklistedtokes < ActiveRecord::Migration[5.1]
  def change
    remove_columns :blacklisted_tokens, :expires_at, :status, :created_on, :updated_at
    rename_column :blacklisted_tokens, :created_at, :blacklisted_on
  end
end
