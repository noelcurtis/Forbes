class CreateNeighborhoodUsers < ActiveRecord::Migration
  def change
    create_table :neighborhood_users do |t|
      t.integer :neighborhood_id
      t.integer :user_id
      t.boolean :primary, :default => false

      t.timestamps
    end
  end
end
