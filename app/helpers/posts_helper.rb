module PostsHelper
  def get_edit_path(post)
    puts "+++++++++++++++++++++++++++++++"
    if defined?(@place) and defined?(@neighborhood)
      edit_neighborhood_place_post_path(@neighborhood, @place, post)
    elsif defined?(@neighborhood)
      edit_neighborhood_post_path(@neighborhood, post)
    else
      edit_post_path(post)
    end
  end

  def get_delete_path(post)
    if defined?(@place) and defined?(@neighborhood)
      neighborhood_place_post_path(@neighborhood, @place, post)
    elsif defined?(@neighborhood)
      neighborhood_post_path(@neighborhood, post)
    else
      post_path(post)
    end
  end
end
