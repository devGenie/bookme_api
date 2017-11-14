class RenameTableAuthentications < ActiveRecord::Migration[5.1]
  def change
    rename_table :authentications, :blacklisted_tokens
  end
end
