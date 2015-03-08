class AddNameAndPictureToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :picture_url, :string
  end
end
