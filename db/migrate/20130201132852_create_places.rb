class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string  :category
      t.string  :name
      t.string  :street_address
      t.integer :zipcode
      t.string  :website
      t.string  :phone
      t.text    :description
      t.integer :neighborhood_id

      t.timestamps
    end
  end
end
