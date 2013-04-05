module ApplicationHelper

  def already_favorited?(object)
    type = object.class
    if type == Neighborhood
      return Favorite.where("user_id = ? AND neighborhood_id = ?", current_user.id, object.id).exists?
    else
      return Favorite.where("user_id = ? AND place_id = ?", current_user.id, object.id).exists?
    end
  end

  def tab_active?(action)
    params[:controller] == action.to_s
  end
end
