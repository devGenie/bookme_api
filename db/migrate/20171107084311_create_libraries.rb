class CreateLibraries < ActiveRecord::Migration[5.1]
  def change
    create_table :libraries do |t|
      t.string :name, null:false
      t.string :location, null:false
      t.string :image_url, null:false
      t.string :contacts, null:false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
