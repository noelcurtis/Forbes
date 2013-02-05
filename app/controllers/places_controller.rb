class PlacesController < ApplicationController
  include OwnershipsHelper

  before_filter :authenticate_user!
  before_filter :set_neighborhood
  before_filter :set_categories, only: [:index, :new, :edit]
  before_filter :allow_if_owner, only: [:edit, :update, :destroy]

  def index
    @places = @neighborhood.places

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @places }
    end
  end

  def show
    @place = Place.find(params[:id])
    @posts = @place.posts
    @post = Post.new
    @submit_post_url = neighborhood_place_posts_path(@neighborhood, @place)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @place }
    end
  end

  def new
    @place = Place.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @place }
    end
  end

  def edit
  end

  def create
    @place = Place.new(params[:place])

    if @place.save
      photo = Photo.new(image: params[:image], user_id: current_user.id, neighborhood_id: @neighborhood.id, place_id: @place.id)
      photo.save
      ownership = current_user.ownerships.build(place_id: @place.id).save
      redirect_to neighborhood_place_path(@neighborhood, @place)
    else
      redirect_to new_neighborhood_place_path(@neighborhood)
    end
  end

  def update
      if @place.update_attributes(params[:place])
        redirect_to neighborhood_place_path(@neighborhood, @place)
      else
        redirect_to edit_neighborhood_place_path(@neighborhood, @place)
      end
  end

  def destroy
    @place.destroy

    respond_to do |format|
      format.html { redirect_to places_url }
      format.json { head :no_content }
    end
  end

  private

  def set_categories
    @categories = [ ['Restaurant', 'Restaurant'], ['Park', 'Park'], ['School', 'School'], ['Bar', 'Bar'] ]
  end

  def set_neighborhood
    @neighborhood = Neighborhood.find(params[:neighborhood_id])
  end

  def allow_if_owner
    @place = Place.find(params[:id])
    redirect_to root_path unless is_owner?(@place)
  end
end
