module OwnershipsHelper

  def is_owner?(object)
    object.owners.include?(current_user)
  end
end
