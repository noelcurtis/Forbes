class UsersController < ApplicationController
  before_filter :authenticate_user!

  def add_neighborhood
    neighborhood = Neighborhood.find(params[:neighborhood_id])
    user = User.find(params[:id])
    user.neighborhoods << neighborhood
    if user.save
      redirect_to action: "main_feed", :id => user.id
    end
  end

  def main_feed
    @user = User.find(params[:id]) 
  end
end
