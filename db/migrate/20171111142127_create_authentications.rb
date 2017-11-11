class CreateAuthentications < ActiveRecord::Migration[5.1]
  def change
    create_table  :authentications do |t|
      t.string    :token, null:false, unique:true
      t.references :user, foreign_key: true, null:false
      t.datetime :created_on, null:false, default: -> { 'CURRENT_TIMESTAMP' } 
      t.datetime :expires_at, null:false
      t.boolean  :status, null:false, default:true
      t.timestamps
    end
    add_index :authentications, :token
  end
end