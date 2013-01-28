class Photo < ActiveRecord::Base
  attr_accessible :image, :user_id, :neighborhood_id
  
  has_attached_file :image, :styles => { :medium => "200x200>" }
 
  belongs_to :user
  belongs_to :neighborhood 
end
