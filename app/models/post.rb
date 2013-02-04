class Post < ActiveRecord::Base
  attr_accessible :content, :user_id, :neighborhood_id, :place_id

  belongs_to :user
  belongs_to :neighborhood
  belongs_to :place

  validates_presence_of :user_id, :content
end
