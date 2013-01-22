class User < ActiveRecord::Base
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :gender, :birthday

  validates_presence_of :first_name, :last_name, :gender, :birthday

  has_and_belongs_to_many :neighborhoods
end
