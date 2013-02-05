class CreateOwnerships < ActiveRecord::Migration
  def change
    create_table :ownerships do |t|
      t.integer :user_id
      t.integer :neighborhood_id
      t.integer :place_id

      t.timestamps
    end
  end
end
