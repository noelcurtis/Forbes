class User < ActiveRecord::Base
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :gender, :birthday

  validates_presence_of :first_name, :last_name, :gender, :birthday

  has_and_belongs_to_many :neighborhoods
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

  def has_profile_picture?
    self.profile_picture_id != nil 
  end

  def profile_picture
    Photo.find(self.profile_picture_id)
  end
end
