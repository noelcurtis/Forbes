class Photo < ActiveRecord::Base
  attr_accessible :image, :user_id, :neighborhood_id
  
  has_attached_file :image, :styles => { :neighborhood_thumbnail  => "95x75>",
                                         :medium                  => "300x300>" },
                    :default_url => '/images/missing_profile_picture.png'
 
  belongs_to :user
  belongs_to :neighborhood 
  
  validates_presence_of :user_id
end
