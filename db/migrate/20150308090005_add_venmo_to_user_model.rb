class AddVenmoToUserModel < ActiveRecord::Migration
  def change
    add_column :users, :venmo_access_token, :string
    add_column :users, :venmo_username, :string
  end
end
