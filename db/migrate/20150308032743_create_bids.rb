class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :user_id
      t.integer :bid
      t.integer :time_limit

      t.timestamps null: false
    end
  end
end
