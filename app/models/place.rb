class Place < ActiveRecord::Base
  attr_accessible :category, :name, :street_address, :zipcode, :website, :phone, :description, :neighborhood_id, :user_id

  belongs_to :neighborhood
  belongs_to :user
  has_many :photos
  has_many :posts
  has_many :favorites
end
