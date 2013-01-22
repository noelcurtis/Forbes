class CreateNeighborhoodUserJoinTable < ActiveRecord::Migration
  def change
    create_table :neighborhoods_users, :id => false do |t|
      t.integer :neighborhood_id
      t.integer :user_id
    end
  end
end
