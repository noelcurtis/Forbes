class DropNeighborhoodsUsers < ActiveRecord::Migration
  def up
    drop_table :neighborhoods_users
  end

  def down
    create_table :neighborhoods_users, :id => false do |t|
      t.integer :neighborhood_id
      t.integer :user_id
    end
  end
end
