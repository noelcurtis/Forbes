module NeighborhoodsHelper
  def is_primary?(neighborhood)
    current_user.primary_neighborhood == neighborhood
  end
end
