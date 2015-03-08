class AddRelationshipStatusToUserModel < ActiveRecord::Migration
  def change
    add_column :users, :relationship_status, :string
    add_index :users, :fb_id
  end
end
