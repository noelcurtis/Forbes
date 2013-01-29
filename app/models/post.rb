class Post < ActiveRecord::Base
  attr_accessible :content, :user_id, :neighborhood_id

  belongs_to :user
  belongs_to :neighborhood

  validates_presence_of :user_id, :content
end
