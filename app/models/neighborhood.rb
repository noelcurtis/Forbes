class Neighborhood < ActiveRecord::Base
  attr_accessible :name, :city_id, :description
  
  has_and_belongs_to_many :users
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
