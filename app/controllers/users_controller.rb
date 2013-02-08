class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :allow_if_current_user, only: [:main_feed, :edit, :update]

  def add_neighborhood
    @neighborhood = Neighborhood.find(params[:neighborhood_id])
    user = User.find(params[:id])
    if user.neighborhoods.include? @neighborhood
      flash[:notice] = "You already belong to this neighborhood"
    else
      user.neighborhoods << @neighborhood 
      flash[:success] = "You've successfully joined this neighborhood"
    end
    redirect_to @neighborhood 
  end

  def main_feed
    @all_friends_posts = Post.where(:user_id => current_user.friends).order("created_at DESC").limit(8)
    @neighborhood_friends_posts = Post.where(user_id: current_user.friends, neighborhood_id: current_user.neighborhoods)
                                      .order("created_at DESC")
                                      .limit(30)
    if current_user.friends.empty?
      @suggested_friends = User.where("id != ?", current_user.id).limit(5)
    else  
      @suggested_friends = User.where("id not in (?) AND id != ?", current_user.friends, current_user.id).limit(5)
    end
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
      flash[:success] = "Profile successfully updated"
      redirect_to @user
    else
      flash[:error] = "Unable to update your profile"
      render action: "edit" 
    end
  end

  private
    def allow_if_current_user
      @user = User.find(params[:id])
      redirect_to root_path unless @user == current_user
    end
end
