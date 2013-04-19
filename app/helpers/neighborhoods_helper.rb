module NeighborhoodsHelper
  def is_primary?(neighborhood)
    current_user.primary_neighborhood == neighborhood
  end

  def show_edit?
    params[:controller] == 'neighborhoods'
  end
end
