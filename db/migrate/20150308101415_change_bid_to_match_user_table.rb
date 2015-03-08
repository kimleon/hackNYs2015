class ChangeBidToMatchUserTable < ActiveRecord::Migration
  def change
    change_column :bids, :user_id, :string
  end
end
