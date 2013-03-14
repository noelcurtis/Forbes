class Ownership < ActiveRecord::Base
  attr_accessible :neighborhood_id, :place_id, :user_id

  belongs_to :user
  belongs_to :neighborhood
  belongs_to :place
  belongs_to :owner, class_name: "User", foreign_key: :user_id
end
