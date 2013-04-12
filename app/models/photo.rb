class Photo < ActiveRecord::Base
  attr_accessible :image, :user_id, :neighborhood_id, :place_id
  
  include Shared::PaperclipHelper
  has_attachment :image, :styles => { :small   => "100x100>",
                                         :medium  => "300x300>" }
 
  belongs_to :user
  belongs_to :neighborhood 
  belongs_to :place
  
  validates_presence_of :user_id

  default_scope lambda { order('id ASC') }
end
