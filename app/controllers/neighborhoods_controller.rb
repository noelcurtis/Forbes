class NeighborhoodsController < ApplicationController
  before_filter :authenticate_user!
  
  def find
    @user = current_user
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
      redirect_to @neighborhood
    elsif @neighborhood.errors.messages.values.include?(["can't be blank"])
      puts "+++++++++++++++++++++++++++"
      redirect_to :action => "find"
    elsif @neighborhood.errors.messages.values.include?(["has already been taken"])
      puts "----------------------------"
      flash[:notice] = "It looks like this neighborhood already exists."
      @neighborhood = Neighborhood.where("name  = ? AND city_id = ?", params[:neighborhood][:name], params[:neighborhood][:city_id]).first
      redirect_to @neighborhood
    end
  end
  
  def show
    @neighborhood = Neighborhood.find(params[:id])
    @posts = @neighborhood.posts.order("created_at DESC")
    @post = Post.new
  end 
end
