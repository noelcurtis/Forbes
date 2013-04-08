class User < ActiveRecord::Base
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :gender, :birthday

  validates_presence_of :first_name, :last_name, :gender, :birthday

  has_many :neighborhood_users
  has_many :neighborhoods, through: :neighborhood_users

  has_many :posts, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :places
  has_many :favorites, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :ownerships, dependent: :destroy

  def full_name
    self.first_name + " " + self.last_name
  end

  def profile_picture(size = :small)
    if self.profile_picture_id != nil 
      photo = Photo.find(self.profile_picture_id)
      photo.image.url(size)
    else
      "missing_profile_picture.png"
    end
  end

  def primary_neighborhood
    neighborhood_users.where(primary: true).first.neighborhood
  end
end
