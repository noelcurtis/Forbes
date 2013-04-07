class NeighborhoodUser < ActiveRecord::Base
  attr_accessible :primary, :user_id, :neighborhood_id

  belongs_to :user
  belongs_to :neighborhood
end
