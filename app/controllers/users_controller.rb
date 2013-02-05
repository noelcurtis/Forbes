class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :allow_if_current_user, only: [:main_feed, :edit, :update]

  def add_neighborhood
    neighborhood = Neighborhood.find(params[:neighborhood_id])
    user = User.find(params[:id])
    user.neighborhoods << neighborhood
    if user.save
      redirect_to action: "main_feed", :id => user.id
    end
  end

  def main_feed
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      if !params[:image].nil?
        photo = Photo.new(image: params[:image], user_id: @user.id) 
        photo.save
        @user.profile_picture_id = photo.id
        @user.save
      end    
      redirect_to @user
    else
      render action: "edit" 
    end
  end

  private
    def allow_if_current_user
      @user = User.find(params[:id])
      redirect_to root_path unless @user == current_user
    end
end
