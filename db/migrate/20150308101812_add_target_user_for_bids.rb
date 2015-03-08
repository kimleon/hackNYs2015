class AddTargetUserForBids < ActiveRecord::Migration
  def change
    add_column :bids, :biddee, :string
    remove_column :bids, :user_id
    add_column :bids, :bidder, :string
  end
end
