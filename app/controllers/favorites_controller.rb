class FavoritesController < ApplicationController
  before_filter :authenticate_user!

  def add_to_favorites
    favorite = Favorite.new
    favorite.user_id = current_user.id
    unless params[:neighborhood_id].nil? 
      favorite.place_id = params[:id]
    else
      favorite.neighborhood_id = params[:id]
    end
    favorite.save!
    if params[:neighborhood_id].nil?
      redirect_to controller: "neighborhoods", action: "show", id: params[:id]
    else
      redirect_to controller: "places", action: "show", neighborhood_id: params[:neighborhood_id], id: params[:id]
    end
  end
end
