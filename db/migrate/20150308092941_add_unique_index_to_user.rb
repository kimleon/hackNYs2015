class AddUniqueIndexToUser < ActiveRecord::Migration
  def change
    remove_index :users, column: :fb_id
    add_index :users, :fb_id, unique: true
  end
end
