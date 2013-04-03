module UsersHelper
  # I know this is ugly but its not my fault :(
  def current_user_or(user, user_id)
    if user_id.present?
      user.id == user_id ? user : User.find(user_id)
    else
      user
    end
  end
end
