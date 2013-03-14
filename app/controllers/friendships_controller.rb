class FriendshipsController < ApplicationController
  before_filter :authenticate_user!
 
  def index
    @user = User.find(params[:user_id])
    @friendships = @user.friendships
  end

  def create
    friend = User.find(params[:friend_id])
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    inverse_friendship = friend.friendships.build(:friend_id => current_user.id)
 
    if @friendship.save and inverse_friendship.save
      flash[:notice] = "Added friend."
      redirect_to root_url
    else
      flash[:error] = "Unable to add friend."
      redirect_to root_url
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    friend = User.find(@friendship.friend_id)
    inverse_friendship = friend.friendships.find_by_friend_id(current_user.id)
    @friendship.destroy and inverse_friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to current_user
  end    
end
