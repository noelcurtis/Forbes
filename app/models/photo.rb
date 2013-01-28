class Photo < ActiveRecord::Base
  attr_accessible :image, :user_id, :neighborhood_id
  
  has_attached_file :image, :styles => { :medium => "300x300>" }
 
  belongs_to :user
  belongs_to :neighborhood 
end
