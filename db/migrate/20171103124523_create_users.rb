class CreateUsers < ActiveRecord::Migration[5.1]
  def self.up
    create_table :users do |t|
      t.string :first_name ,null:false
      t.string :last_name ,null:false
      t.string :email ,null:false
      t.string :password , null:false
      t.datetime :date_added , null:false

      t.timestamps
    end
  end
end
