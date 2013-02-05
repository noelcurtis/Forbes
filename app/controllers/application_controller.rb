class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    "/users/#{current_user.id}/main_feed"
  end

end
