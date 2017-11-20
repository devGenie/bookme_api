class AddUserConstraints < ActiveRecord::Migration[5.1]
  def change
      add_reference :authors, :user, index: true
      add_reference :categories, :user, index: true
  end
end
