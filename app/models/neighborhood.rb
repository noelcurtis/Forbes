class Neighborhood < ActiveRecord::Base
  attr_accessible :name, :city_id, :description
  
  has_many :neighborhood_users
  has_many :users, through: :neighborhood_users

  belongs_to :city
  has_many :posts, dependent: :destroy
  has_many :photos
  has_many :places
  has_many :favorites, dependent: :destroy
  has_many :ownerships, dependent: :destroy
  has_many :owners, through: :ownerships
  
  validates_presence_of   :name
  validates_uniqueness_of :name, :scope => :city_id
end
