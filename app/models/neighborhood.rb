class Neighborhood < ActiveRecord::Base
  attr_accessible :name, :city_id
  
  has_and_belongs_to_many :users
  belongs_to :city
  has_many :posts
  has_many :photos
end
