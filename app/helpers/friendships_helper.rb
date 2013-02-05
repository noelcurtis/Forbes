module FriendshipsHelper

  def already_friends?(user)
    current_user.friends.include?(user) 
  end
end
