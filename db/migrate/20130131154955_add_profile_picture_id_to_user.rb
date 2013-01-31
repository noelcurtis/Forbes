class AddProfilePictureIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :profile_picture_id, :integer
  end
end
