module UsersHelper
  def user_nav_link(user, user_id)
    current_user = find_user(user, user_id)
    link_to current_user.full_name, current_user, class: 'profile-name'
  end

  def find_user(user, user_id)
    if user_id.present?
      user.id == user_id ? user : User.find(user_id)
    else
      user
    end
  end
end
