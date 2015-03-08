class AddUserToBid < ActiveRecord::Migration
  def change
    add_reference :bids, :user, index: true
    add_foreign_key :bids, :users
  end
end
