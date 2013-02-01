class AddPlaceIdToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :place_id, :integer
  end
end
