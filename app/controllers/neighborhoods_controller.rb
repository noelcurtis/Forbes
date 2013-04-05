class NeighborhoodsController < ApplicationController
  include OwnershipsHelper
  before_filter :authenticate_user!
  before_filter :allow_if_owner, only: [:edit, :update, :destroy]
  
  def find
    @user = current_user
    @states = State.order :name
  end

  def join
    @neighborhood = Neighborhood.find(params[:id])
    current_user.neighborhoods << @neighborhood
    flash[:success] = "You've successfully joined this neighborhood"
    redirect_to @neighborhood
  end

  def index
    if params[:city_id]
      @neighborhoods = Neighborhood.where("city_id = ?", params[:city_id]).order(:name) 
    else
      @neighborhoods = Neighborhood.order(:name)
    end
    respond_to do |format|
        format.html { render :layout => !request.xhr? }
    end
  end

  def preview
    @neighborhood = Neighborhood.find(params[:id])
  end

  def new
    @neighborhood = Neighborhood.new
    @city = City.find(params[:city_id])
  end

  def create
    @neighborhood = Neighborhood.new(params[:neighborhood])
    if @neighborhood.save
      current_user.neighborhoods << @neighborhood
      current_user.save
      photo = Photo.new(image: params[:image], user_id: current_user.id, neighborhood_id: @neighborhood.id)
      photo.save
      ownership = current_user.ownerships.build(neighborhood_id: @neighborhood.id).save
      flash[:success] = "Neighborhod successfully created"
      redirect_to @neighborhood
    elsif @neighborhood.errors.messages.values.include?(["can't be blank"])
      redirect_to :action => "find"
    elsif @neighborhood.errors.messages.values.include?(["has already been taken"])
      flash[:notice] = "It looks like this neighborhood already exists."
      @neighborhood = Neighborhood.where("name  = ? AND city_id = ?", params[:neighborhood][:name], params[:neighborhood][:city_id]).first
      redirect_to @neighborhood
    end
  end
  
  def show
    @neighborhood = Neighborhood.find(params[:id])
    @posts = @neighborhood.posts.order("created_at DESC")
    @post = Post.new
    @submit_post_url = neighborhood_posts_path(@neighborhood)
  end

  def select_photos
    @neighborhood = Neighborhood.find(params[:id])
    @photo = Photo.new
    @submit_url = "/neighborhoods/#{@neighborhood.id}/add_photos"
  end

  def add_photos
    @neighborhood = Neighborhood.find(params[:id])
    @photo = Photo.new(params[:photo])
    @photo.save
    @neighborhood.photos << @photo
    redirect_to @neighborhood 
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def allow_if_owner
    @neighborhood = Neighborhood.find(params[:id])
    redirect_to root_path unless is_owner?(@neighborhood)
  end
end
